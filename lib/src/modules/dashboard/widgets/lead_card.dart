
import '../../../app/app.dart';

class LeadCard extends StatelessWidget {
  final Demo lead;
  final VoidCallback onCreateCallRequest;

  const LeadCard({
    super.key,
    required this.lead,
    required this.onCreateCallRequest,
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
                        lead.studentName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      if (lead.contactNo?.isNotEmpty == true)
                        Text(
                          lead.contactNo!,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.lightPrimary,
                          ),
                        ),
                    ],
                  ),
                ),
                _buildStatusChip(),
              ],
            ),
            const SizedBox(height: 8),
            if (lead.standard.isNotEmpty) ...[
              _buildInfoRow('Standard', lead.standard),
            ],
            if (lead.board?.isNotEmpty == true) ...[
              _buildInfoRow('Board', lead.board!),
            ],
            if (lead.schoolName?.isNotEmpty == true) ...[
              _buildInfoRow('School', lead.schoolName!),
            ],
            if (lead.city?.isNotEmpty == true) ...[
              _buildInfoRow('City', lead.city!),
            ],
            const SizedBox(height: 8),
            _buildInfoRow('Demo Date', _formatDate(lead.demoDate)),
            if (lead.assignedTo?.isNotEmpty == true) ...[
              _buildInfoRow('Assigned To', lead.assignedTo!),
            ],
            if (lead.sourceOfLead?.isNotEmpty == true) ...[
              const SizedBox(height: 4),
              _buildInfoRow('Source', lead.sourceOfLead!),
            ],
            if (lead.notes?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text(
                lead.notes!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CommonOutlinedButton(
                    label: 'Create Call Request',
                    onPressed: onCreateCallRequest,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Navigate to edit lead
                  },
                  tooltip: 'Edit Lead',
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // TODO: Show lead options menu
                  },
                  tooltip: 'More Options',
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
    switch (lead.status.toLowerCase()) {
      case 'pending':
        color = AppColors.warning;
        break;
      case 'contacted':
        color = AppColors.info;
        break;
      case 'interested':
        color = AppColors.success;
        break;
      case 'not interested':
        color = AppColors.danger;
        break;
      case 'finalized':
        color = AppColors.lightPrimary;
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
        lead.status.toUpperCase(),
        style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall!.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall!.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
