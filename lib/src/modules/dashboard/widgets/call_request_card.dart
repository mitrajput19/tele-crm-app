
import 'package:flutter/material.dart';
import 'package:tele_crm_app/src/app/app.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_styles.dart';
import '../../../core/widgets/common_card.dart';
import '../../../core/widgets/common_filled_button.dart';
import '../../../core/widgets/common_outlined_button.dart';
import '../../../domain/entities/call_request.dart';

class CallRequestCard extends StatelessWidget {
  final CallRequest callRequest;
  final VoidCallback onMakeCall;
  final Function(String) onUpdateStatus;

  const CallRequestCard({
    super.key,
    required this.callRequest,
    required this.onMakeCall,
    required this.onUpdateStatus,
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
                        callRequest.customerName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        callRequest.phoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.lightPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(),
                _buildPriorityChip(),
              ],
            ),
            if (callRequest.notes?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text(
                callRequest.notes!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Requested: ${_formatDateTime(callRequest.requestedAt)}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                if (callRequest.scheduledAt != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    'Scheduled: ${_formatDateTime(callRequest.scheduledAt!)}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.lightPrimary,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CommonFilledButton(
                    label: 'Call Now',
                    onPressed: callRequest.status == 'pending' || 
                              callRequest.status == 'assigned' 
                        ? onMakeCall 
                        : null,
                    icon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () => _launchWhatsApp(callRequest.phoneNumber),
                  tooltip: 'WhatsApp',
                ),
                PopupMenuButton<String>(
                  onSelected: onUpdateStatus,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'pending',
                      child: Text('Mark as Pending'),
                    ),
                    const PopupMenuItem(
                      value: 'assigned',
                      child: Text('Mark as Assigned'),
                    ),
                    const PopupMenuItem(
                      value: 'completed',
                      child: Text('Mark as Completed'),
                    ),
                    const PopupMenuItem(
                      value: 'cancelled',
                      child: Text('Cancel Request'),
                    ),
                  ],
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color color;
    switch (callRequest.status) {
      case 'pending':
        color = AppColors.warning;
        break;
      case 'assigned':
        color = AppColors.info;
        break;
      case 'in_progress':
        color = AppColors.lightPrimary;
        break;
      case 'completed':
        color = AppColors.success;
        break;
      case 'cancelled':
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
        callRequest.status.toUpperCase(),
        style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall!.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriorityChip() {
    Color color;
    switch (callRequest.priority) {
      case 'high':
        color = AppColors.danger;
        break;
      case 'medium':
        color = AppColors.warning;
        break;
      case 'low':
        color = AppColors.success;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        callRequest.priority.toUpperCase(),
        style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall!.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
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

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
