
import 'package:flutter/material.dart';
import 'package:tele_crm_app/src/app/app.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_styles.dart';
import '../../../core/widgets/common_card.dart';
import '../../../domain/entities/call_log.dart';

class CallLogCard extends StatelessWidget {
  final CallLog callLog;

  const CallLogCard({
    super.key,
    required this.callLog,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        callLog.customerName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        callLog.phoneNumber,
                        style: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium!.copyWith(
                          color: AppColors.lightPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(),
                const SizedBox(width: 8),
                _buildCallTypeIcon(),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDateTime(callLog.startTime),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                if (callLog.duration != null) ...[
                  const SizedBox(width: 16),
                  Icon(
                    Icons.timer,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDuration(callLog.duration!),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
            if (callLog.outcome != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.label,
                    size: 16,
                    color: _getOutcomeColor(callLog.outcome!),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Outcome: ${callLog.outcome}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: _getOutcomeColor(callLog.outcome!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
            if (callLog.notes?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text(
                callLog.notes!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (callLog.followUpDate != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Follow-up: ${_formatDate(callLog.followUpDate!)}',
                      style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall!.copyWith(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color color;
    switch (callLog.status) {
      case 'connected':
        color = AppColors.success;
        break;
      case 'no_answer':
        color = AppColors.warning;
        break;
      case 'busy':
        color = AppColors.info;
        break;
      case 'failed':
        color = AppColors.danger;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        callLog.status.replaceAll('_', ' ').toUpperCase(),
        style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall!.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCallTypeIcon() {
    return Icon(
      callLog.callType == 'outbound' ? Icons.call_made : Icons.call_received,
      color: callLog.callType == 'outbound' ? AppColors.success : AppColors.info,
      size: 20,
    );
  }

  Color _getOutcomeColor(String outcome) {
    switch (outcome.toLowerCase()) {
      case 'interested':
        return AppColors.success;
      case 'not_interested':
        return AppColors.danger;
      case 'callback':
        return AppColors.warning;
      case 'converted':
        return AppColors.lightPrimary;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes > 0) {
      return '${minutes}m ${remainingSeconds}s';
    } else {
      return '${remainingSeconds}s';
    }
  }
}
