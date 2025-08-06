
import 'dart:developer';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app.dart';
import '../../domain/entities/call_request.dart';

class CallService {
  static final CallService _instance = CallService._internal();
  factory CallService() => _instance;
  CallService._internal();

  /// Make a direct call without showing the dialer
  Future<bool> makeDirectCall(String phoneNumber) async {
    try {
      log('Making direct call to $phoneNumber');
      // Clean the phone number (remove spaces, special characters)
      String cleanNumber = _cleanPhoneNumber(phoneNumber);
      
      if (cleanNumber.isEmpty) {
        throw Exception('Invalid phone number');
      }

      // Check if call permission is granted
      if (await _hasCallPermission()) {
        // Make direct call using flutter_phone_direct_caller
        bool? result = await FlutterPhoneDirectCaller.callNumber(cleanNumber);
        return result ?? false;
      } else {
        // Request permission
        bool granted = await _requestCallPermission();
        if (granted) {
          bool? result = await FlutterPhoneDirectCaller.callNumber(cleanNumber);
          return result ?? false;
        } else {
          throw Exception('Call permission denied');
        }
      }
    } catch (e) {
      print('Error making direct call: $e');
      return false;
    }
  }

  /// Make a call using the system dialer (fallback option)
  Future<bool> makeCallWithDialer(String phoneNumber) async {
    try {
      String cleanNumber = _cleanPhoneNumber(phoneNumber);
      final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);
      
      if (await canLaunchUrl(phoneUri)) {
        return await launchUrl(phoneUri);
      } else {
        throw Exception('Cannot launch phone dialer');
      }
    } catch (e) {
      print('Error making call with dialer: $e');
      return false;
    }
  }

  /// Check if the app has call permission
  Future<bool> _hasCallPermission() async {
    return await Permission.phone.isGranted;
  }

  /// Request call permission
  Future<bool> _requestCallPermission() async {
    PermissionStatus status = await Permission.phone.request();
    return status == PermissionStatus.granted;
  }

  /// Clean phone number by removing spaces, dashes, and other characters
  String _cleanPhoneNumber(String phoneNumber) {
    // Remove all non-numeric characters except + at the beginning
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Ensure + is only at the beginning
    if (cleaned.startsWith('+')) {
      cleaned = '+' + cleaned.substring(1).replaceAll('+', '');
    }
    
    return cleaned;
  }

  /// Validate phone number format
  bool isValidPhoneNumber(String phoneNumber) {
    String cleaned = _cleanPhoneNumber(phoneNumber);
    // Basic validation: should have at least 10 digits
    return RegExp(r'^\+?\d{10,15}$').hasMatch(cleaned);
  }
}


// Call state management
enum CallState {
  idle,
  dialing,
  ringing,
  connected,
  ended,
  failed
}

class CallManager {
  static final CallManager _instance = CallManager._internal();
  factory CallManager() => _instance;
  CallManager._internal();

  CallState _currentState = CallState.idle;
  String? _currentCallId;
  DateTime? _callStartTime;

  CallState get currentState => _currentState;
  String? get currentCallId => _currentCallId;
  DateTime? get callStartTime => _callStartTime;

  Future<bool> initiateCall(CallRequest callRequest) async {
    try {
      _currentState = CallState.dialing;
      _currentCallId = callRequest.id;
      _callStartTime = DateTime.now();

      // Make the actual call
      bool success = await getIt<CallService>().makeDirectCall(callRequest.phoneNumber);
      
      if (success) {
        _currentState = CallState.ringing;
        // You can add a timer here to automatically mark as connected after some time
        // or implement phone state listeners to detect actual call state
        return true;
      } else {
        _currentState = CallState.failed;
        return false;
      }
    } catch (e) {
      _currentState = CallState.failed;
      print('Error initiating call: $e');
      return false;
    }
  }

  void markCallAsConnected() {
    if (_currentState == CallState.ringing) {
      _currentState = CallState.connected;
    }
  }

  void endCall() {
    _currentState = CallState.ended;
    _currentCallId = null;
    _callStartTime = null;
  }

  Duration? getCallDuration() {
    if (_callStartTime != null && _currentState == CallState.connected) {
      return DateTime.now().difference(_callStartTime!);
    }
    return null;
  }
}