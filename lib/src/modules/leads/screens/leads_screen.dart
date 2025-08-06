

import '../../../app/app.dart';
import '../bloc/leads_bloc.dart';
import '../widgets/widgets.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeadsBloc(
        supabaseService: SupabaseService(),
      )..add(LoadLeadsEvent()),
      child: const LeadsView(),
    );
  }
}

class LeadsView extends StatefulWidget {
  const LeadsView({super.key});

  @override
  State<LeadsView> createState() => _LeadsViewState();
}

class _LeadsViewState extends State<LeadsView> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSelectionMode = false;
  final Set<String> _selectedLeads = <String>{};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isSelectionMode 
              ? '${_selectedLeads.length} Selected' 
              : 'Leads Management',
        ),
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: _selectedLeads.isNotEmpty ? _bulkCreateCalls : null,
              tooltip: 'Create Calls',
            ),
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: _selectedLeads.isNotEmpty ? _bulkAssign : null,
              tooltip: 'Bulk Assign',
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _exitSelectionMode,
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showCreateLeadDialog,
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CommonTextField(
              controller: _searchController,
              hintText: 'Search leads...',
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                context.read<LeadsBloc>().add(SearchLeadsEvent(query: value));
              },
            ),
          ),
          
          // Leads List
          Expanded(
            child: BlocConsumer<LeadsBloc, LeadsState>(
              listener: (context, state) {
                if (state is LeadsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is LeadsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (state is LeadsLoaded) {
                  final leads = state.displayLeads;
                  
                  if (leads.isEmpty) {
                    return const NoDataFound(
                      message: 'No leads found',
                     
                    );
                  }
                  
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<LeadsBloc>().add(LoadLeadsEvent());
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: leads.length,
                      itemBuilder: (context, index) {
                        final lead = leads[index];
                        final isSelected = _selectedLeads.contains(lead.id);
                        
                        return LeadListItem(
                          lead: lead,
                          isSelected: isSelected,
                          isSelectionMode: _isSelectionMode,
                          onTap: () => _handleLeadTap(lead),
                          onLongPress: () => _handleLeadLongPress(lead),
                          onCallPressed: () => _createCallRequest(lead),
                          onEditPressed: () => _editLead(lead),
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
      ),
      floatingActionButton: _isSelectionMode
          ? null
          : FloatingActionButton(
              onPressed: _showCreateLeadDialog,
              child: const Icon(Icons.add),
            ),
    );
  }

  void _handleLeadTap(Demo lead) {
    if (_isSelectionMode) {
      _toggleLeadSelection(lead.id);
    } else {
      // Navigate to lead details
      _showLeadDetails(lead);
    }
  }

  void _handleLeadLongPress(Demo lead) {
    if (!_isSelectionMode) {
      setState(() {
        _isSelectionMode = true;
        _selectedLeads.add(lead.id);
      });
    }
  }

  void _toggleLeadSelection(String leadId) {
    setState(() {
      if (_selectedLeads.contains(leadId)) {
        _selectedLeads.remove(leadId);
        if (_selectedLeads.isEmpty) {
          _isSelectionMode = false;
        }
      } else {
        _selectedLeads.add(leadId);
      }
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedLeads.clear();
    });
  }

  void _createCallRequest(Demo lead) {
    context.read<LeadsBloc>().add(
      CreateCallRequestFromLead(
        lead: lead,
        priority: 'medium',
      ),
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Call request created successfully')),
    );
  }

  void _editLead(Demo lead) {
    // Navigate to edit lead screen
  }

  void _showLeadDetails(Demo lead) {
    // Navigate to lead details screen
  }

  void _showCreateLeadDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateLeadDialog(
        onLeadCreated: (lead) {
          context.read<LeadsBloc>().add(CreateLeadEvent(lead: lead));
        },
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => LeadFilterWidget(
        onFilterApplied: (status, assignedTo, priority) {
          context.read<LeadsBloc>().add(
            FilterLeadsEvent(
              status: status,
              assignedTo: assignedTo,
              priority: priority,
            ),
          );
        },
      ),
    );
  }

  void _bulkCreateCalls() {
    for (final leadId in _selectedLeads) {
      // Find the lead and create call request
      final state = context.read<LeadsBloc>().state;
      if (state is LeadsLoaded) {
        final lead = state.leads.firstWhere((l) => l.id == leadId);
        context.read<LeadsBloc>().add(
          CreateCallRequestFromLead(lead: lead),
        );
      }
    }
    _exitSelectionMode();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedLeads.length} call requests created'),
      ),
    );
  }

  void _bulkAssign() {
    // Show agent selection dialog and assign selected leads
    _exitSelectionMode();
  }
}
