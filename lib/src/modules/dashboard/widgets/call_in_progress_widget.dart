
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_styles.dart';
import '../../../core/widgets/common_filled_button.dart';
import '../../../core/widgets/common_outlined_button.dart';
import '../../../core/widgets/common_card.dart';
import '../../../domain/entities/call_request.dart';
import '../../../domain/entities/call_log.dart';

class CallInProgressWidget extends StatefulWidget {
  final CallRequest callRequest;
  final CallLog callLog;
  final DateTime startTime;
  final Function(String outcome, String? notes, DateTime? followUpDate) onEndCall;

  const CallInProgressWidget({
    super.key,
    required this.callRequest,
    required this.callLog,
    required this.startTime,
    required this.onEndCall,
  });

  @override
  State<CallInProgressWidget> createState() => _CallInProgressWidgetState();
}

class _CallInProgressWidgetState extends State<CallInProgressWidget>
    with TickerProviderStateMixin {
  late Timer _timer;
  Duration _callDuration = Duration.zero;
  late AnimationController _pulseController;
  final TextEditingController _notesController = TextEditingController();
  String _selectedOutcome = '';
  DateTime? _followUpDate;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _callDuration = DateTime.now().difference(widget.startTime);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'Call in Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48), // Balance the back button
                ],
              ),
            ),

            // Call Info
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Customer Info
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.lightPrimary.withOpacity(0.1),
                        child: Text(
                          widget.callRequest.customerName.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.callRequest.customerName,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.callRequest.phoneNumber,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.lightPrimary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Call Duration
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(
                                0.1 + (0.1 * _pulseController.value),
                              ),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: AppColors.success.withOpacity(
                                  0.3 + (0.2 * _pulseController.value),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: AppColors.success,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDuration(_callDuration),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 32),

                      // Call Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCallActionButton(
                            icon: Icons.mic_off,
                            label: 'Mute',
                            color: Colors.grey[600]!,
                            onPressed: () {
                              // TODO: Implement mute functionality
                            },
                          ),
                          _buildCallActionButton(
                            icon: Icons.volume_up,
                            label: 'Speaker',
                            color: Colors.grey[600]!,
                            onPressed: () {
                              // TODO: Implement speaker functionality
                            },
                          ),
                          _buildCallActionButton(
                            icon: Icons.call_end,
                            label: 'End Call',
                            color: AppColors.danger,
                            onPressed: _showEndCallDialog,
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Notes Section
                      CommonCard(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Call Notes',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _notesController,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  hintText: 'Add notes about this call...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: color),
        ),
      ],
    );
  }

  void _showEndCallDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Call'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('How did the call go?'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                'Interested',
                'Not Interested',
                'Callback',
                'No Answer',
                'Busy',
              ].map((outcome) {
                return ChoiceChip(
                  label: Text(outcome),
                  selected: _selectedOutcome == outcome,
                  onSelected: (selected) {
                    setState(() {
                      _selectedOutcome = selected ? outcome : '';
                    });
                  },
                );
              }).toList(),
            ),
            if (_selectedOutcome == 'Callback') ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
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
                child: Text(
                  _followUpDate != null
                      ? 'Follow-up: ${_followUpDate!.day}/${_followUpDate!.month}/${_followUpDate!.year}'
                      : 'Set Follow-up Date',
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: _selectedOutcome.isNotEmpty
                ? () {
                    Navigator.of(context).pop();
                    widget.onEndCall(
                      _selectedOutcome,
                      _notesController.text.trim().isNotEmpty
                          ? _notesController.text.trim()
                          : null,
                      _followUpDate,
                    );
                  }
                : null,
            child: const Text('End Call'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }
}
