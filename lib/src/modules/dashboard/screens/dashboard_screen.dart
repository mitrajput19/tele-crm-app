
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_styles.dart';
import '../../../core/widgets/common_filled_button.dart';
import '../../../core/widgets/common_card.dart';
import '../../../core/widgets/common_loader.dart';
import '../../../core/widgets/common_refresh_indicator.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/dashboard_stats_widget.dart';
import '../widgets/call_request_card.dart';
import '../widgets/call_log_card.dart';
import '../widgets/lead_card.dart';
import '../widgets/call_in_progress_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeleCRM Dashboard'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<DashboardBloc>().add(RefreshDashboard());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Call Queue'),
            Tab(text: 'Call Logs'),
            Tab(text: 'Leads'),
          ],
        ),
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CallInProgress) {
            return CallInProgressWidget(
              callRequest: state.callRequest,
              callLog: state.callLog,
              startTime: state.startTime,
              onEndCall: (outcome, notes, followUpDate) {
                context.read<DashboardBloc>().add(
                  EndCall(
                    callLogId: state.callLog.id,
                    outcome: outcome,
                    notes: notes,
                    followUpDate: followUpDate,
                  ),
                );
              },
            );
          }

          if (state is DashboardLoading) {
            return const Center(child: CommonLoader());
          }

          if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading dashboard',
                    style: AppStyles.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: AppStyles.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CommonFilledButton(
                    text: 'Retry',
                    onPressed: () {
                      context.read<DashboardBloc>().add(LoadDashboard());
                    },
                  ),
                ],
              ),
            );
          }

          if (state is DashboardLoaded) {
            return CommonRefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(RefreshDashboard());
              },
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(state),
                  _buildCallQueueTab(state),
                  _buildCallLogsTab(state),
                  _buildLeadsTab(state),
                ],
              ),
            );
          }

          return const Center(child: CommonLoader());
        },
      ),
    );
  }

  Widget _buildOverviewTab(DashboardLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardStatsWidget(stats: state.stats),
          const SizedBox(height: 24),
          Text(
            'Recent Call Requests',
            style: AppStyles.titleLarge,
          ),
          const SizedBox(height: 16),
          if (state.callRequests.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No call requests found'),
              ),
            )
          else
            ...state.callRequests.take(5).map(
              (request) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CallRequestCard(
                  callRequest: request,
                  onMakeCall: () {
                    context
                        .read<DashboardBloc>()
                        .add(MakeCall(callRequest: request));
                  },
                  onUpdateStatus: (status) {
                    context.read<DashboardBloc>().add(
                      UpdateCallRequestStatus(
                        requestId: request.id,
                        status: status,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCallQueueTab(DashboardLoaded state) {
    final pendingRequests = state.callRequests
        .where((r) => r.status == 'pending' || r.status == 'assigned')
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Call Queue (${pendingRequests.length})',
                style: AppStyles.titleLarge,
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  context.read<DashboardBloc>().add(
                    LoadCallRequests(status: value == 'all' ? null : value),
                  );
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'all', child: Text('All')),
                  const PopupMenuItem(value: 'pending', child: Text('Pending')),
                  const PopupMenuItem(value: 'assigned', child: Text('Assigned')),
                  const PopupMenuItem(value: 'in_progress', child: Text('In Progress')),
                ],
                child: const Icon(Icons.filter_list),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (pendingRequests.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No pending call requests'),
              ),
            )
          else
            ...pendingRequests.map(
              (request) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CallRequestCard(
                  callRequest: request,
                  onMakeCall: () {
                    context
                        .read<DashboardBloc>()
                        .add(MakeCall(callRequest: request));
                  },
                  onUpdateStatus: (status) {
                    context.read<DashboardBloc>().add(
                      UpdateCallRequestStatus(
                        requestId: request.id,
                        status: status,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCallLogsTab(DashboardLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Call Logs (${state.callLogs.length})',
                style: AppStyles.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () {
                  // TODO: Show date picker for filtering
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (state.callLogs.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No call logs found'),
              ),
            )
          else
            ...state.callLogs.map(
              (log) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CallLogCard(callLog: log),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLeadsTab(DashboardLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Leads (${state.leads.length})',
                style: AppStyles.titleLarge,
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  context.read<DashboardBloc>().add(
                    LoadLeadsForCalling(status: value == 'all' ? null : value),
                  );
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'all', child: Text('All')),
                  const PopupMenuItem(value: 'pending', child: Text('Pending')),
                  const PopupMenuItem(value: 'contacted', child: Text('Contacted')),
                  const PopupMenuItem(value: 'interested', child: Text('Interested')),
                  const PopupMenuItem(value: 'not_interested', child: Text('Not Interested')),
                ],
                child: const Icon(Icons.filter_list),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (state.leads.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No leads found'),
              ),
            )
          else
            ...state.leads.map(
              (lead) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: LeadCard(
                  lead: lead,
                  onCreateCallRequest: () {
                    // TODO: Create call request from lead
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
