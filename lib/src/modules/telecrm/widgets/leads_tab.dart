
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/app.dart';
import '../../../domain/entities/demo_model.dart';
import '../bloc/telecrm_bloc.dart';
import '../widgets/lead_item_widget.dart';

class LeadsTab extends StatefulWidget {
  const LeadsTab({super.key});

  @override
  State<LeadsTab> createState() => _LeadsTabState();
}

class _LeadsTabState extends State<LeadsTab> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search and filter bar
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: CommonTextField(
                  controller: _searchController,
                  hintText: 'Search leads...',
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      context.read<TeleCrmBloc>().add(LoadTeleCrmData());
                    } else {
                      context.read<TeleCrmBloc>().add(SearchLeads(query: value));
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list),
                onSelected: (value) {
                  setState(() {
                    _selectedFilter = value;
                  });
                  context.read<TeleCrmBloc>().add(LoadLeads(status: value));
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: null,
                    child: Text('All Leads'),
                  ),
                  const PopupMenuItem(
                    value: 'fresh',
                    child: Text('Fresh'),
                  ),
                  const PopupMenuItem(
                    value: 'contacted',
                    child: Text('Contacted'),
                  ),
                  const PopupMenuItem(
                    value: 'demo_scheduled',
                    child: Text('Demo Scheduled'),
                  ),
                  const PopupMenuItem(
                    value: 'demo_completed',
                    child: Text('Demo Completed'),
                  ),
                  const PopupMenuItem(
                    value: 'converted',
                    child: Text('Converted'),
                  ),
                  const PopupMenuItem(
                    value: 'not_interested',
                    child: Text('Not Interested'),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Leads list
        Expanded(
          child: BlocBuilder<TeleCrmBloc, TeleCrmState>(
            builder: (context, state) {
              if (state is TeleCrmLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is TeleCrmError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${state.message}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      CommonFilledButton(
                        onPressed: () {
                          context.read<TeleCrmBloc>().add(LoadTeleCrmData());
                        },
                        text: 'Retry',
                      ),
                    ],
                  ),
                );
              }

              if (state is TeleCrmLoaded) {
                final leads = state.leads;

                if (leads.isEmpty) {
                  return const NoDataFound(
                    message: 'No leads found',
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<TeleCrmBloc>().add(LoadTeleCrmData());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: leads.length,
                    itemBuilder: (context, index) {
                      final lead = leads[index];
                      return LeadItemWidget(
                        lead: lead,
                        onTap: () => _showLeadDetails(context, lead),
                        onCall: () => _makeCall(context, lead),
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  void _showLeadDetails(BuildContext context, Demo lead) {
    Navigator.pushNamed(
      context,
      '/lead-details',
      arguments: lead,
    );
  }

  void _makeCall(BuildContext context, Demo lead) {
    if (lead.contactNo != null) {
      // TODO: Implement actual call functionality
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Calling ${lead.contactNo}...'),
        ),
      );
    }
  }
}
