
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../../app/app.dart';
import '../../../core/core.dart';
import '../../../domain/entities/call_request.dart';
import '../../../domain/entities/call_log.dart';
import '../../dashboard/bloc/dashboard_bloc.dart';

class CallingScreen extends StatefulWidget {
  final CallRequest callRequest;

  const CallingScreen({
    super.key,
    required this.callRequest,
  });

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  Timer? _timer;
  Duration _callDuration = Duration.zero;
  bool _isCallActive = false;
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  String _callStatus = 'Connecting...';

  @override
  void initState() {
    super.initState();
    _startCall();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCall() {
    setState(() {
      _isCallActive = true;
      _callStatus = 'Connecting...';
    });

    // Simulate call connection
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _callStatus = 'Connected';
        });
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _callDuration = Duration(seconds: timer.tick);
        });
      }
    });
  }

  void _endCall() {
    _timer?.cancel();
    setState(() {
      _isCallActive = false;
      _callStatus = 'Call Ended';
    });

    // Show call summary dialog
    _showCallSummaryDialog();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _toggleSpeaker() {
    setState(() {
      _isSpeakerOn = !_isSpeakerOn;
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _showCallSummaryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CallSummaryDialog(
        callRequest: widget.callRequest,
        duration: _callDuration,
        onSummarySubmitted: (outcome, notes, followUpDate) {
          _saveCallLog(outcome, notes, followUpDate);
        },
      ),
    );
  }

  void _saveCallLog(String outcome, String notes, DateTime? followUpDate) {
    final callLog = CallLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      callRequestId: widget.callRequest.id,
      leadId: widget.callRequest.leadId,
      customerName: widget.callRequest.customerName,
      phoneNumber: widget.callRequest.phoneNumber,
      callType: 'outbound',
      status: 'completed',
      startTime: DateTime.now().subtract(_callDuration),
      endTime: DateTime.now(),
      duration: _callDuration.inSeconds,
      notes: notes,
      outcome: outcome,
      followUpDate: followUpDate,
      agentId: 'current_user_id', // Get from auth
      agentName: 'Current User', // Get from profile
    );

    context.read<DashboardBloc>().add(CreateCallLog(callLog: callLog));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  Text(
                    _callStatus,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Contact Info
            Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.callRequest.customerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.callRequest.phoneNumber,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                if (_isCallActive)
                  Text(
                    _formatDuration(_callDuration),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),

            const Spacer(),

            // Call Controls
            Container(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  // Control Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CallControlButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        isActive: _isMuted,
                        onPressed: _toggleMute,
                        backgroundColor: _isMuted ? Colors.red : Colors.grey.shade800,
                      ),
                      _CallControlButton(
                        icon: Icons.dialpad,
                        onPressed: () {
                          // Show dialpad
                        },
                        backgroundColor: Colors.grey.shade800,
                      ),
                      _CallControlButton(
                        icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                        isActive: _isSpeakerOn,
                        onPressed: _toggleSpeaker,
                        backgroundColor: _isSpeakerOn ? AppColors.lightPrimary : Colors.grey.shade800,
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // End Call Button
                  GestureDetector(
                    onTap: _endCall,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isActive;
  final Color backgroundColor;

  const _CallControlButton({
    required this.icon,
    required this.onPressed,
    this.isActive = false,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

class CallSummaryDialog extends StatefulWidget {
  final CallRequest callRequest;
  final Duration duration;
  final Function(String outcome, String notes, DateTime? followUpDate) onSummarySubmitted;

  const CallSummaryDialog({
    super.key,
    required this.callRequest,
    required this.duration,
    required this.onSummarySubmitted,
  });

  @override
  State<CallSummaryDialog> createState() => _CallSummaryDialogState();
}

class _CallSummaryDialogState extends State<CallSummaryDialog> {
  final TextEditingController _notesController = TextEditingController();
  String _selectedOutcome = 'interested';
  DateTime? _followUpDate;

  final List<String> _outcomes = [
    'interested',
    'not_interested',
    'callback',
    'converted',
    'no_response',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Call Summary'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Call Duration: ${_formatDuration(widget.duration)}'),
            const SizedBox(height: 16),
            
            const Text('Outcome:'),
            DropdownButton<String>(
              value: _selectedOutcome,
              isExpanded: true,
              items: _outcomes.map((outcome) {
                return DropdownMenuItem(
                  value: outcome,
                  child: Text(outcome.replaceAll('_', ' ').toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOutcome = value!;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            const Text('Notes:'),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add call notes...',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text('Follow-up Date:'),
            ListTile(
              title: Text(_followUpDate?.toString().split(' ')[0] ?? 'No follow-up'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() {
                    _followUpDate = date;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSummarySubmitted(
              _selectedOutcome,
              _notesController.text,
              _followUpDate,
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
