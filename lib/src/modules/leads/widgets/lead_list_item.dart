
import '../../../app/app.dart';

class LeadListItem extends StatelessWidget {
  final Demo lead;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onCallPressed;
  final VoidCallback onEditPressed;

  const LeadListItem({
    Key? key,
    required this.lead,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onTap,
    required this.onLongPress,
    required this.onCallPressed,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: CommonCard(
        padding: EdgeInsets.zero,
        child: Material(
          color: isSelected ? AppColors.lightPrimary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isSelectionMode)
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: Icon(
                            isSelected 
                                ? Icons.check_circle 
                                : Icons.radio_button_unchecked,
                            color: isSelected 
                                ? AppColors.lightPrimary 
                                : Colors.grey,
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lead.studentName,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (lead.contactNo != null)
                              Row(
                                children: [
                                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    lead.contactNo!,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            if (lead.alternateContactNo != null) ...[
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.email, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      lead.alternateContactNo!,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (!isSelectionMode) ...[
                        IconButton(
                          icon:  Icon(Icons.call, color: AppColors.lightPrimary),
                          onPressed: onCallPressed,
                          tooltip: 'Create Call',
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          onPressed: onEditPressed,
                          tooltip: 'Edit Lead',
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildStatusChip(lead.status),
                      const SizedBox(width: 8),
                      _buildPriorityChip(lead.sourceOfLead ?? 'medium'),
                      const Spacer(),
                      Text(
                        _formatDate(lead.createdAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  if (lead.notes != null && lead.notes!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      lead.notes!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'new':
        chipColor = Colors.blue;
        break;
      case 'contacted':
        chipColor = Colors.orange;
        break;
      case 'qualified':
        chipColor = Colors.green;
        break;
      case 'demo_scheduled':
        chipColor = Colors.purple;
        break;
      case 'demo_completed':
        chipColor = Colors.teal;
        break;
      case 'customer':
        chipColor = Colors.green[700]!;
        break;
      case 'lost':
        chipColor = Colors.red;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        status.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(
          color: chipColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    Color chipColor;
    switch (priority.toLowerCase()) {
      case 'low':
        chipColor = Colors.green;
        break;
      case 'medium':
        chipColor = Colors.orange;
        break;
      case 'high':
        chipColor = Colors.red;
        break;
      case 'urgent':
        chipColor = Colors.red[900]!;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
          color: chipColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../domain/entities/demo_model.dart';

class LeadListItem extends StatelessWidget {
  final Demo lead;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onCallPressed;
  final VoidCallback onEditPressed;

  const LeadListItem({
    super.key,
    required this.lead,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onTap,
    required this.onLongPress,
    required this.onCallPressed,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isSelected 
                ? Border.all(color: AppColors.primary, width: 2)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar with initials
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: _getStatusColor(lead.status),
                    child: Text(
                      _getInitials(lead.studentName),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Lead info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lead.studentName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (lead.contactNo != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            lead.contactNo!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Status and actions
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(lead.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getStatusDisplayName(lead.status),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(lead.status),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (!isSelectionMode) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: onCallPressed,
                              icon: const Icon(Icons.call, size: 20),
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              onPressed: onEditPressed,
                              icon: const Icon(Icons.edit, size: 20),
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Additional info
              Row(
                children: [
                  if (lead.standard.isNotEmpty) ...[
                    Icon(Icons.school, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Class ${lead.standard}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  if (lead.standard.isNotEmpty && lead.board != null) ...[
                    const SizedBox(width: 16),
                  ],
                  if (lead.board != null) ...[
                    Icon(Icons.menu_book, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      lead.board!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.event, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Demo: ${DateTimeHelper.formatDate(lead.demoDate)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    DateTimeHelper.timeAgo(lead.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              if (lead.notes != null && lead.notes!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  lead.notes!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'fresh':
        return Colors.green;
      case 'contacted':
        return Colors.blue;
      case 'qualified':
        return Colors.orange;
      case 'demo_scheduled':
        return Colors.purple;
      case 'demo_completed':
        return Colors.teal;
      case 'converted':
        return Colors.green[700]!;
      case 'not_interested':
        return Colors.red;
      case 'postponed':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  String _getStatusDisplayName(String status) {
    switch (status.toLowerCase()) {
      case 'demo_scheduled':
        return 'Demo Scheduled';
      case 'demo_completed':
        return 'Demo Completed';
      case 'not_interested':
        return 'Not Interested';
      default:
        return status.substring(0, 1).toUpperCase() + status.substring(1);
    }
  }
}
