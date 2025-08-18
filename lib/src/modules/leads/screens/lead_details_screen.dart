import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../app/app.dart';
import '../../../core/core.dart';
import '../../../domain/entities/demo_model.dart';
import '../../../domain/entities/audit_log.dart';
import '../../../domain/entities/call_recording.dart';
import '../bloc/lead_details_bloc.dart';
import '../../telecrm/screens/call_recording_details_screen.dart';

class LeadDetailsScreen extends StatefulWidget {
  final String leadId;

  const LeadDetailsScreen({super.key, required this.leadId});

  @override
  State<LeadDetailsScreen> createState() => _LeadDetailsScreenState();
}

class _LeadDetailsScreenState extends State<LeadDetailsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<LeadDetailsBloc>().add(LoadLeadDetails(widget.leadId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Lead Details', style: Theme.of(context).textTheme.tsSemiBold18),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => context.pop(),
        ),
        actions: [
          BlocBuilder<LeadDetailsBloc, LeadDetailsState>(
            builder: (context, state) {
              if (state is LeadDetailsLoaded) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: AppColors.info),
                      onPressed: () => _editLead(state.lead),
                    ),
                    if (state.lead.contactNo != null)
                      IconButton(
                        icon: Icon(Icons.call, color: AppColors.success),
                        onPressed: () => _callLead(state.lead),
                      ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Details'),
            Tab(text: 'History'),
            Tab(text: 'Recordings'),
          ],
        ),
      ),
      body: BlocBuilder<LeadDetailsBloc, LeadDetailsState>(
        builder: (context, state) {
          if (state is LeadDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (state is LeadDetailsError) {
            return Center(child: Text(state.message));
          }
          
          if (state is LeadDetailsLoaded) {
            log('Lead Details Loaded: ${state.callRecordings.length} recordings, ${state.auditLogs.length} history items');
            return TabBarView(
              controller: _tabController,
              children: [
                _buildDetailsTab(state.lead),
                _buildHistoryTab(state.auditLogs),
                _buildRecordingsTab(state.callRecordings),
              ],
            );
          }
          
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildDetailsTab(Demo lead) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard('Student Information', [
            _buildInfoRow('Name', lead.studentName),
            if (lead.contactNo != null) _buildInfoRow('Phone', lead.contactNo!),
            if (lead.alternateContactNo != null) _buildInfoRow('Alt Phone', lead.alternateContactNo!),
            if (lead.schoolName != null) _buildInfoRow('School', lead.schoolName!),
            if (lead.board != null) _buildInfoRow('Board', lead.board!),
            _buildInfoRow('Standard', lead.standard),
          ]),
          SizedBox(height: 16),
          _buildInfoCard('Demo Information', [
            _buildInfoRow('Status', lead.status),
            _buildInfoRow('Demo Date', lead.demoDate.timeAgo),
            if (lead.assignedTo != null) _buildInfoRow('Assigned To', lead.assignedTo!),
            if (lead.demoPerformedBy != null) _buildInfoRow('Demo By', lead.demoPerformedBy!),
            if (lead.sourceOfLead != null) _buildInfoRow('Source', lead.sourceOfLead!),
          ]),
          SizedBox(height: 16),
          _buildInfoCard('Financial Information', [
            if (lead.quoteAmount != null) _buildInfoRow('Quote Amount', '₹${lead.quoteAmount!.toStringAsFixed(2)}'),
            if (lead.finalizedAmount != null) _buildInfoRow('Finalized Amount', '₹${lead.finalizedAmount!.toStringAsFixed(2)}'),
          ]),
          SizedBox(height: 16),
          _buildInfoCard('Timeline', [
            _buildInfoRow('Created', lead.createdAt.timeAgo),
            _buildInfoRow('Updated', lead.updatedAt.timeAgo),
            if (lead.followUpDate != null) _buildInfoRow('Follow-up Date', lead.followUpDate!.timeAgo),
            if (lead.postponeDate != null) _buildInfoRow('Postpone Date', lead.postponeDate!.timeAgo),
          ]),
          if (lead.notes != null) ...[
            SizedBox(height: 16),
            _buildInfoCard('Notes', [
              Text(lead.notes!, style: Theme.of(context).textTheme.tsRegular14),
            ]),
          ],
          if (lead.followUpNote != null) ...[
            SizedBox(height: 16),
            _buildInfoCard('Follow-up Notes', [
              Text(lead.followUpNote!, style: Theme.of(context).textTheme.tsRegular14),
            ]),
          ],
          if (lead.postponeNote != null) ...[
            SizedBox(height: 16),
            _buildInfoCard('Postpone Notes', [
              Text(lead.postponeNote!, style: Theme.of(context).textTheme.tsRegular14),
            ]),
          ],
          if (lead.notInterestedReason != null) ...[
            SizedBox(height: 16),
            _buildInfoCard('Not Interested Reason', [
              Text(lead.notInterestedReason!, style: Theme.of(context).textTheme.tsRegular14),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryTab(List<AuditLog> auditLogs) {
    if (auditLogs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No history available', style: Theme.of(context).textTheme.tsRegular16),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: auditLogs.length,
      itemBuilder: (context, index) {
        final log = auditLogs[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(_getActionIcon(log.action), size: 20, color: _getActionColor(log.action)),
                    SizedBox(width: 8),
                    Text(log.action.toUpperCase(), style: Theme.of(context).textTheme.tsSemiBold14),
                    Spacer(),
                    Text(log.createdAt.timeAgo, style: Theme.of(context).textTheme.tsGrayRegular12),
                  ],
                ),
                if (log.userName != null) ...[
                  SizedBox(height: 4),
                  Text('by ${log.userName}', style: Theme.of(context).textTheme.tsGrayRegular12),
                ],
                if (log.description != null) ...[
                  SizedBox(height: 8),
                  Text(log.description!, style: Theme.of(context).textTheme.tsRegular14),
                ],
                if (log.oldValues != null || log.newValues != null) ...[
                  SizedBox(height: 8),
                  _buildChangesWidget(log.oldValues, log.newValues),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecordingsTab(List<CallRecording> recordings) {
    if (recordings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.call, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No call recordings available', style: Theme.of(context).textTheme.tsRegular16),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: recordings.length,
      itemBuilder: (context, index) {
        final recording = recordings[index];
        final recordingData = recording.toJson();
        final hasRecording = recordingData['recording_file_url'] != null;
        
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallRecordingDetailsScreen(
                    recording: recordingData,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        hasRecording ? Icons.audiotrack : Icons.call,
                        color: hasRecording ? Colors.blue : Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recordingData['phone_number'] ?? 'Unknown',
                              style: Theme.of(context).textTheme.tsSemiBold14,
                            ),
                            Text(
                              _formatDateTime(recordingData['start_time']),
                              style: Theme.of(context).textTheme.tsGrayRegular12,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${recordingData['duration_seconds'] ?? 0}s',
                            style: Theme.of(context).textTheme.tsRegular12,
                          ),
                          if (hasRecording)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Recorded',
                                style: Theme.of(context).textTheme.tsRegular10.copyWith(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        'Call ${recordingData['call_type'] ?? 'Unknown'}',
                        style: Theme.of(context).textTheme.tsGrayRegular12,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
                    ],
                  ),
                  if (recordingData['call_notes'] != null) ...[
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        recordingData['call_notes'],
                        style: Theme.of(context).textTheme.tsRegular12,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.tsSemiBold16),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: Theme.of(context).textTheme.tsGrayRegular12),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.tsRegular14),
          ),
        ],
      ),
    );
  }

  Widget _buildChangesWidget(Map<String, dynamic>? oldValues, Map<String, dynamic>? newValues) {
    if (oldValues == null && newValues == null) return SizedBox();
    
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (oldValues != null) ...[
            Text('From:', style: Theme.of(context).textTheme.tsGrayRegular12),
            Text(oldValues.toString(), style: Theme.of(context).textTheme.tsRegular12),
          ],
          if (newValues != null) ...[
            if (oldValues != null) SizedBox(height: 4),
            Text('To:', style: Theme.of(context).textTheme.tsGrayRegular12),
            Text(newValues.toString(), style: Theme.of(context).textTheme.tsRegular12),
          ],
        ],
      ),
    );
  }

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'create': return Icons.add_circle;
      case 'update': return Icons.edit;
      case 'delete': return Icons.delete;
      case 'call': return Icons.call;
      case 'email': return Icons.email;
      case 'status_change': return Icons.swap_horiz;
      default: return Icons.info;
    }
  }

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case 'create': return Colors.green;
      case 'update': return Colors.blue;
      case 'delete': return Colors.red;
      case 'call': return Colors.orange;
      case 'email': return Colors.purple;
      case 'status_change': return Colors.teal;
      default: return Colors.grey;
    }
  }

  String _formatDateTime(dynamic dateTime) {
    if (dateTime == null) return 'Unknown time';
    try {
      final dt = DateTime.parse(dateTime.toString());
      return DateFormat('MMM dd, yyyy hh:mm a').format(dt);
    } catch (e) {
      return dateTime.toString();
    }
  }

  void _editLead(Demo lead) {
    context.push('${AppRoutes.addLead}?leadId=${lead.id}');
  }

  Future<void> _callLead(Demo lead) async {
    final phoneNumber = lead.contactNo ?? '';
    
    if (phoneNumber.isEmpty) {
      showSnackbarBloc('No phone number available for this lead', SnackbarType.warning);
      return;
    }
    
    try {
      final callService = getIt<CallService>();
      final success = await callService.makeDirectCall(phoneNumber);
      
      if (success) {
        showSnackbarBloc('Calling ${lead.studentName}...', SnackbarType.success);
      } else {
        showSnackbarBloc('Failed to make call', SnackbarType.danger);
      }
    } catch (e) {
      showSnackbarBloc('Error making call: ${e.toString()}', SnackbarType.danger);
    }
  }
}