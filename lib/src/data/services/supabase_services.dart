import '../../app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;
  
  // Singleton pattern
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // Auth Methods
  Future<User?> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  Future<User?> signUp(String email, String password, {Map<String, dynamic>? metadata}) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: metadata,
      );
      return response.user;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  User? get currentUser => _client.auth.currentUser;
  String? get currentUserId => _client.auth.currentUser?.id;

  // Profile Methods
  Future<Profile?> getCurrentProfile() async {
    final userId = currentUserId;
    if (userId == null) return null;

    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('user_id', userId)
          .single();
      return Profile.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get current profile: $e');
    }
  }

  Future<Profile> createProfile(Profile profile) async {
    try {
      final response = await _client
          .from('profiles')
          .insert(profile.toJson())
          .select()
          .single();
      return Profile.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create profile: $e');
    }
  }

  Future<Profile> updateProfile(String id, Map<String, dynamic> updates) async {
    try {
      final response = await _client
          .from('profiles')
          .update(updates)
          .eq('id', id)
          .select()
          .single();
      return Profile.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<List<Profile>> getProfiles({String? managerId, String? role}) async {
    try {
      var query = _client.from('profiles').select();
      
      if (managerId != null) {
        query = query.eq('manager_id', managerId);
      }
      if (role != null) {
        query = query.eq('role', role);
      }
      
      final response = await query;
      return response.map<Profile>((json) => Profile.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get profiles: $e');
    }
  }

  // Attendance Methods
  Future<Attendance> punchIn({
    required double latitude,
    required double longitude,
    String? imageUrl,
    String? notes,
  }) async {
    final profile = await getCurrentProfile();
    if (profile == null) throw Exception('No current profile found');

    try {
      final attendance = Attendance(
        id: '',
        profileId: profile.id,
        punchIn: DateTime.now(),
        date: DateTime.now(),
        punchInLatitude: latitude,
        punchInLongitude: longitude,
        punchInImageUrl: imageUrl,
        notes: notes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final response = await _client
          .from('attendance')
          .insert(attendance.toJson())
          .select()
          .single();
      return Attendance.fromJson(response);
    } catch (e) {
      throw Exception('Failed to punch in: $e');
    }
  }

  Future<Attendance> punchOut({
    required String attendanceId,
    required double latitude,
    required double longitude,
    String? imageUrl,
    String? notes,
  }) async {
    try {
      final punchOutTime = DateTime.now();
      
      // Get the attendance record to calculate total hours
      final attendance = await getAttendanceById(attendanceId);
      final totalHours = punchOutTime.difference(attendance.punchIn).inMinutes / 60;

      final updates = {
        'punch_out': punchOutTime.toIso8601String(),
        'punch_out_latitude': latitude,
        'punch_out_longitude': longitude,
        'punch_out_image_url': imageUrl,
        'total_hours': totalHours,
        'notes': notes ?? attendance.notes,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await _client
          .from('attendance')
          .update(updates)
          .eq('id', attendanceId)
          .select()
          .single();
      return Attendance.fromJson(response);
    } catch (e) {
      throw Exception('Failed to punch out: $e');
    }
  }

  Future<Attendance> getAttendanceById(String id) async {
    try {
      final response = await _client
          .from('attendance')
          .select()
          .eq('id', id)
          .single();
      return Attendance.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get attendance: $e');
    }
  }

  Future<List<Attendance>> getAttendanceRecords({
    String? profileId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = _client.from('attendance').select();
      
      if (profileId != null) {
        query = query.eq('profile_id', profileId);
      }
      if (startDate != null) {
        query = query.gte('date', startDate.toIso8601String().split('T')[0]);
      }
      if (endDate != null) {
        query = query.lte('date', endDate.toIso8601String().split('T')[0]);
      }
      
      final response = await query.order('date', ascending: false);
      return response.map<Attendance>((json) => Attendance.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get attendance records: $e');
    }
  }

  Future<Attendance?> getTodayAttendance({String? profileId}) async {
    final profile = await getCurrentProfile();
    final targetProfileId = profileId ?? profile?.id;
    if (targetProfileId == null) return null;

    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      final response = await _client
          .from('attendance')
          .select()
          .eq('profile_id', targetProfileId)
          .eq('date', today)
          .maybeSingle();
      
      return response != null ? Attendance.fromJson(response) : null;
    } catch (e) {
      throw Exception('Failed to get today attendance: $e');
    }
  }

  // Activity Methods
  Future<Activity> createActivity(Activity activity) async {
    try {
      final response = await _client
          .from('activities')
          .insert(activity.toJson())
          .select()
          .single();
      return Activity.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create activity: $e');
    }
  }

  Future<Activity> updateActivity(String id, Map<String, dynamic> updates) async {
    try {
      final response = await _client
          .from('activities')
          .update(updates)
          .eq('id', id)
          .select()
          .single();
      return Activity.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update activity: $e');
    }
  }

  Future<Activity> endActivity(String id, double latitude, double longitude) async {
    try {
      final endTime = DateTime.now();
      final activity = await getActivityById(id);
      final duration = endTime.difference(activity.startTime).inMinutes;

      final updates = {
        'end_time': endTime.toIso8601String(),
        'end_latitude': latitude,
        'end_longitude': longitude,
        'total_duration_minutes': duration,
        'status': 'completed',
        'updated_at': DateTime.now().toIso8601String(),
      };

      return await updateActivity(id, updates);
    } catch (e) {
      throw Exception('Failed to end activity: $e');
    }
  }

  Future<Activity> getActivityById(String id) async {
    try {
      final response = await _client
          .from('activities')
          .select()
          .eq('id', id)
          .single();
      return Activity.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get activity: $e');
    }
  }

  Future<List<Activity>> getActivities({
    String? profileId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = _client.from('activities').select();
      
      if (profileId != null) {
        query = query.eq('profile_id', profileId);
      }
      if (status != null) {
        query = query.eq('status', status);
      }
      if (startDate != null) {
        query = query.gte('start_time', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('start_time', endDate.toIso8601String());
      }
      
      final response = await query.order('start_time', ascending: false);
      return response.map<Activity>((json) => Activity.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get activities: $e');
    }
  }

  // Contact Methods
  Future<Contact> createContact(Contact contact) async {
    try {
      final response = await _client
          .from('contacts')
          .insert(contact.toJson())
          .select()
          .single();
      return Contact.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create contact: $e');
    }
  }

  Future<Contact> updateContact(String id, Map<String, dynamic> updates) async {
    try {
      final response = await _client
          .from('contacts')
          .update(updates)
          .eq('id', id)
          .select()
          .single();
      return Contact.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update contact: $e');
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      await _client.from('contacts').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete contact: $e');
    }
  }

  Future<Contact> getContactById(String id) async {
    try {
      final response = await _client
          .from('contacts')
          .select()
          .eq('id', id)
          .single();
      return Contact.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get contact: $e');
    }
  }
  
  }