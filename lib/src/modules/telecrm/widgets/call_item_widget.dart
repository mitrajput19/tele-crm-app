
import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../domain/entities/call_log.dart';

class CallItemWidget extends StatelessWidget {
  final CallLogModel call;
  final VoidCallback onTap;
  final VoidCallback onCallback;

  const CallItemWidget({
    super.key,
    required this.call,
    required this.onTap,
    required this.onCallback,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Call status icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getCallStatusColor(call.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getCallStatusIcon(call.status),
                  color: _getCallStatusColor(call.status),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              // Call info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      call.customerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      call.phoneNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getCallStatusColor(call.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getStatusDisplayName(call.status),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCallStatusColor(call.status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(call.duration),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          call.startTime.timeAgo,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    if (call.notes != null && call.notes!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        call.notes!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Action buttons
              Column(
                children: [
                  IconButton(
                    onPressed: onCallback,
                    icon: const Icon(
                      Icons.call,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: onTap,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCallStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Icons.call_made;
      case 'missed':
        return Icons.call_missed;
      case 'failed':
        return Icons.call_missed_outgoing;
      case 'busy':
        return Icons.call_missed_outgoing;
      case 'no_answer':
        return Icons.phone_missed;
      default:
        return Icons.call;
    }
  }

  Color _getCallStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'missed':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      case 'busy':
        return Colors.amber;
      case 'no_answer':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  String _getStatusDisplayName(String status) {
    switch (status.toLowerCase()) {
      case 'no_answer':
        return 'No Answer';
      default:
        return status.substring(0, 1).toUpperCase() + status.substring(1);
    }
  }

  String _formatDuration(int? durationSeconds) {
    if (durationSeconds == null || durationSeconds == 0) {
      return '0s';
    }

    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;

    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }
}
