

import '../../../app/app.dart';
import '../../../domain/entities/call_request.dart';

part 'leads_event.dart';
part 'leads_state.dart';

class LeadsBloc extends Bloc<LeadsEvent, LeadsState> {
  final SupabaseService _supabaseService;

  LeadsBloc({required SupabaseService supabaseService})
      : _supabaseService = supabaseService,
        super(LeadsInitial()) {
    on<LoadLeads>(_onLoadLeads);
    on<CreateLead>(_onCreateLead);
    on<UpdateLead>(_onUpdateLead);

    on<FilterLeads>(_onFilterLeads);
    on<SearchLeads>(_onSearchLeads);
    on<CreateCallRequestFromLead>(_onCreateCallRequestFromLead);
    on<UpdateLeadStatus>(_onUpdateLeadStatus);
    on<AssignLead>(_onAssignLead);
    on<BulkUpdateLeads>(_onBulkUpdateLeads);
  }

  Future<void> _onLoadLeads(LoadLeads event, Emitter<LeadsState> emit) async {
    emit(LeadsLoading());
    try {
      final leads = await _supabaseService.getLeadsForCalling();
      emit(LeadsLoaded(leads: leads));
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  Future<void> _onCreateLead(CreateLead event, Emitter<LeadsState> emit) async {
    try {
      final newLead = await _supabaseService.createLead(event.lead);
      if (state is LeadsLoaded) {
        final currentState = state as LeadsLoaded;
        emit(currentState.copyWith(
          leads: [newLead, ...currentState.leads],
        ));
      }
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  Future<void> _onUpdateLead(UpdateLead event, Emitter<LeadsState> emit) async {
    try {
      final updatedLead = await _supabaseService.updateLead(event.leadId, event.updates);
      if (state is LeadsLoaded) {
        final currentState = state as LeadsLoaded;
        final updatedLeads = currentState.leads.map((lead) {
          return lead.id == event.leadId ? updatedLead : lead;
        }).toList();
        emit(currentState.copyWith(leads: updatedLeads));
      }
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  

  Future<void> _onFilterLeads(FilterLeads event, Emitter<LeadsState> emit) async {
    try {
      final leads = await _supabaseService.getLeadsForCalling(
        status: event.status,
        assignedTo: event.assignedTo,
      );
      emit(LeadsLoaded(
        leads: leads,
        currentFilter: LeadsFilter(
          status: event.status,
          assignedTo: event.assignedTo,
          priority: event.priority,
        ),
      ));
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  Future<void> _onSearchLeads(SearchLeads event, Emitter<LeadsState> emit) async {
    if (state is LeadsLoaded) {
      final currentState = state as LeadsLoaded;
      if (event.query.isEmpty) {
        emit(currentState.copyWith(searchQuery: null));
        return;
      }
      
      final filteredLeads = currentState.leads.where((lead) {
        return lead.studentName.toLowerCase().contains(event.query.toLowerCase()) ||
               (lead.contactNo?.contains(event.query) ?? false);
      }).toList();
      
      emit(currentState.copyWith(
        filteredLeads: filteredLeads,
        searchQuery: event.query,
      ));
    }
  }

  Future<void> _onCreateCallRequestFromLead(
    CreateCallRequestFromLead event,
    Emitter<LeadsState> emit,
  ) async {
    try {
      final callRequest = CallRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        leadId: event.lead.id,
        customerName: event.lead.studentName,
        phoneNumber: event.lead.contactNo ?? '',
        alternatePhone: event.lead.alternateContactNo ?? '',
        status: 'pending',
        priority: event.priority ?? 'medium',
        requestedAt: DateTime.now(),
        source: 'mobile',
      );
      
      await _supabaseService.createCallRequest(callRequest);
      
      // Show success message or navigate to call screen
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  Future<void> _onUpdateLeadStatus(
    UpdateLeadStatus event,
    Emitter<LeadsState> emit,
  ) async {
    try {
      await _supabaseService.updateLeadStatus(
        event.leadId,
        event.status,
        additionalData: event.additionalData,
      );
      
      if (state is LeadsLoaded) {
        final currentState = state as LeadsLoaded;
        final updatedLeads = currentState.leads.map((lead) {
          if (lead.id == event.leadId) {
            return lead.copyWith(status: event.status) as Demo;
          }
          return lead;
        }).toList();
        emit(currentState.copyWith(leads: updatedLeads));
      }
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  Future<void> _onAssignLead(AssignLead event, Emitter<LeadsState> emit) async {
    try {
      await _supabaseService.updateLead(event.leadId, {
        'assigned_to': event.agentId,
      });
      
      if (state is LeadsLoaded) {
        final currentState = state as LeadsLoaded;
        final updatedLeads = currentState.leads.map((lead) {
          if (lead.id == event.leadId) {
            return lead.copyWith(demoPerformedBy: event.agentId);
          }
          return lead;
        }).toList();
        emit(currentState.copyWith(leads: updatedLeads));
      }
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }

  Future<void> _onBulkUpdateLeads(
    BulkUpdateLeads event,
    Emitter<LeadsState> emit,
  ) async {
    try {
      for (final leadId in event.leadIds) {
        await _supabaseService.updateLead(leadId, event.updates);
      }
      
      // Reload leads
      add(LoadLeads());
    } catch (e) {
      emit(LeadsError(message: e.toString()));
    }
  }
}
