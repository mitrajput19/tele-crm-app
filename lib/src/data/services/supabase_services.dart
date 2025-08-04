import '../../app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/call_request.dart';
import '../../domain/entities/call_log.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/demo_model.dart';

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
      log(jsonEncode(response.user));
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

  // TeleCRM Dashboard Methods
  Future<DashboardStats> getDashboardStats() async {
    try {
      final response = await _client.rpc('get_dashboard_stats');
      return DashboardStats.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch dashboard stats: $e');
    }
  }

  // Call Request Methods
  Future<List<CallRequest>> getCallRequests({
    String? status,
    String? priority,
    int? limit,
    int? offset,
  }) async {
    try {
      var query = _client.from('call_requests').select();

      if (status != null) {
        query = query.eq('status', status);
      }
      if (priority != null) {
        query = query.eq('priority', priority);
      }

      query = query.order('requested_at', ascending: false);

      if (limit != null) {
        query = query.limit(limit);
      }
      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;
      return (response as List)
          .map((json) => CallRequest.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch call requests: $e');
    }
  }

  Future<CallRequest> createCallRequest(CallRequest callRequest) async {
    try {
      final response = await _client
          .from('call_requests')
          .insert(callRequest.toJson())
          .select()
          .single();
      return CallRequest.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create call request: $e');
    }
  }

  Future<CallRequest> updateCallRequestStatus(String id, String status) async {
    try {
      final response = await _client
          .from('call_requests')
          .update({'status': status, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', id)
          .select()
          .single();
      return CallRequest.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update call request: $e');
    }
  }

  Future<void> assignCallRequest(String id, String agentId) async {
    try {
      await _client
          .from('call_requests')
          .update({'assigned_to': agentId, 'status': 'assigned'})
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to assign call request: $e');
    }
  }

  // Call Log Methods
  Future<List<CallLog>> getCallLogs({
    String? agentId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
    int? offset,
  }) async {
    try {
      var query = _client.from('call_logs').select();

      if (agentId != null) {
        query = query.eq('agent_id', agentId);
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

      query = query.order('start_time', ascending: false);

      if (limit != null) {
        query = query.limit(limit);
      }
      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;
      return (response as List)
          .map((json) => CallLog.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch call logs: $e');
    }
  }

  Future<CallLog> createCallLog(CallLog callLog) async {
    try {
      final response = await _client
          .from('call_logs')
          .insert(callLog.toJson())
          .select()
          .single();
      return CallLog.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create call log: $e');
    }
  }

  Future<CallLog> updateCallLog(String id, Map<String, dynamic> updates) async {
    try {
      final response = await _client
          .from('call_logs')
          .update(updates)
          .eq('id', id)
          .select()
          .single();
      return CallLog.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update call log: $e');
    }
  }

  // Real-time subscriptions
  RealtimeChannel subscribeToCallRequests({
    required void Function(Map<String, dynamic>) onInsert,
    required void Function(Map<String, dynamic>) onUpdate,
    required void Function(Map<String, dynamic>) onDelete,
  }) {
    return _client
        .channel('call_requests_channel')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'call_requests',
          callback: (payload) => onInsert(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'call_requests',
          callback: (payload) => onUpdate(payload.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'call_requests',
          callback: (payload) => onDelete(payload.oldRecord),
        )
        .subscribe();
  }

  // Lead/Demo integration
  Future<List<Demo>> getLeadsForCalling({
    String? status,
    String? assignedTo,
    int? limit,
  }) async {
    try {
      var query = _client.from('demos').select();

      if (status != null) {
        query = query.eq('status', status);
      }
      if (assignedTo != null) {
        query = query.eq('assigned_to', assignedTo);
      }

      query = query.order('demo_date', ascending: true);

      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query;
      return (response as List)
          .map((json) => Demo.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch leads: $e');
    }
  }

  Future<Demo> updateLeadStatus(String id, String status, {
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final updateData = {
        'status': status,
        'updated_at': DateTime.now().toIso8601String(),
        ...?additionalData,
      };

      final response = await _client
          .from('demos')
          .update(updateData)
          .eq('id', id)
          .select()
          .single();
      return Demo.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update lead status: $e');
    }
  }

}
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<User?> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    } on AuthException catch (e) {
      throw Exception('Authentication failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<User?> signUp(String email, String password, {Map<String, dynamic>? data}) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      return response.user;
    } on AuthException catch (e) {
      throw Exception('Sign up failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (e) {
      throw Exception('Sign out failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw Exception('Password reset failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}