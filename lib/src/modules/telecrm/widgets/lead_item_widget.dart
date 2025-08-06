
import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../domain/entities/demo_model.dart';

class LeadItemWidget extends StatelessWidget {
  final Demo lead;
  final VoidCallback onTap;
  final VoidCallback onCall;

  const LeadItemWidget({
    super.key,
    required this.lead,
    required this.onTap,
    required this.onCall,
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
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: _getStatusColor(lead.status),
                child: Text(
                  _getInitials(lead.studentName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (lead.contactNo != null)
                      Text(
                        lead.contactNo!,
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
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.star_border,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.call,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '50s', // TODO: Get actual call duration
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          lead.updatedAt.timeAgo,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'No Feedback', // TODO: Get actual feedback
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              // Action button
              IconButton(
                onPressed: onCall,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
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
      case 'demo_postponed_by_customer':
        return 'Demo Postponed by Customer';
      default:
        return status.substring(0, 1).toUpperCase() + status.substring(1);
    }
  }
}
