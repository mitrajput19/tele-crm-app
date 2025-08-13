
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/services/supabase_services.dart';
import '../../../domain/entities/demo_model.dart';
import '../../../domain/entities/call_log.dart';

// Events
abstract class TeleCrmEvent extends Equatable {
  const TeleCrmEvent();

  @override
  List<Object?> get props => [];
}

class LoadTeleCrmData extends TeleCrmEvent {}

class LoadLeads extends TeleCrmEvent {
  final String? status;
  final String? assignedTo;

  const LoadLeads({this.status, this.assignedTo});

  @override
  List<Object?> get props => [status, assignedTo];
}

class LoadCalls extends TeleCrmEvent {
  final String? status;
  final DateTime? date;

  const LoadCalls({this.status, this.date});

  @override
  List<Object?> get props => [status, date];
}

class SearchLeads extends TeleCrmEvent {
  final String query;

  const SearchLeads({required this.query});

  @override
  List<Object?> get props => [query];
}

// States
abstract class TeleCrmState extends Equatable {
  const TeleCrmState();

  @override
  List<Object?> get props => [];
}

class TeleCrmInitial extends TeleCrmState {}

class TeleCrmLoading extends TeleCrmState {}

class TeleCrmLoaded extends TeleCrmState {
  final List<Demo> leads;
  final List<CallLogModel> calls;
  final Map<String, dynamic> stats;

  const TeleCrmLoaded({
    required this.leads,
    required this.calls,
    required this.stats,
  });

  @override
  List<Object?> get props => [leads, calls, stats];
}

class TeleCrmError extends TeleCrmState {
  final String message;

  const TeleCrmError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc
class TeleCrmBloc extends Bloc<TeleCrmEvent, TeleCrmState> {
  final SupabaseService _supabaseService;

  TeleCrmBloc({required SupabaseService supabaseService})
      : _supabaseService = supabaseService,
        super(TeleCrmInitial()) {
    on<LoadTeleCrmData>(_onLoadTeleCrmData);
    on<LoadLeads>(_onLoadLeads);
    on<LoadCalls>(_onLoadCalls);
    on<SearchLeads>(_onSearchLeads);
  }

  Future<void> _onLoadTeleCrmData(
    LoadTeleCrmData event,
    Emitter<TeleCrmState> emit,
  ) async {
    try {
      emit(TeleCrmLoading());

      final leads = await _supabaseService.getLeads(limit: 50);
      final calls = await _supabaseService.getCallLogs(limit: 50);
      final stats = await _supabaseService.getDashboardStats();

      emit(TeleCrmLoaded(
        leads: leads,
        calls: calls,
        stats: stats.toJson(),
      ));
    } catch (e) {
      emit(TeleCrmError(message: e.toString()));
    }
  }

  Future<void> _onLoadLeads(
    LoadLeads event,
    Emitter<TeleCrmState> emit,
  ) async {
    try {
      final leads = await _supabaseService.getLeads(
        status: event.status,
        assignedTo: event.assignedTo,
        limit: 100,
      );

      if (state is TeleCrmLoaded) {
        final currentState = state as TeleCrmLoaded;
        emit(TeleCrmLoaded(
          leads: leads,
          calls: currentState.calls,
          stats: currentState.stats,
        ));
      }
    } catch (e) {
      emit(TeleCrmError(message: e.toString()));
    }
  }

  Future<void> _onLoadCalls(
    LoadCalls event,
    Emitter<TeleCrmState> emit,
  ) async {
    try {
      final calls = await _supabaseService.getCallLogs(
        status: event.status,
        limit: 100,
      );

      if (state is TeleCrmLoaded) {
        final currentState = state as TeleCrmLoaded;
        emit(TeleCrmLoaded(
          leads: currentState.leads,
          calls: calls,
          stats: currentState.stats,
        ));
      }
    } catch (e) {
      emit(TeleCrmError(message: e.toString()));
    }
  }

  Future<void> _onSearchLeads(
    SearchLeads event,
    Emitter<TeleCrmState> emit,
  ) async {
    try {
      final leads = await _supabaseService.getLeads(limit: 100);
      
      final filteredLeads = leads.where((lead) {
        return lead.studentName.toLowerCase().contains(event.query.toLowerCase()) ||
               (lead.contactNo?.contains(event.query) ?? false) ||
               (lead.schoolName?.toLowerCase().contains(event.query.toLowerCase()) ?? false);
      }).toList();

      if (state is TeleCrmLoaded) {
        final currentState = state as TeleCrmLoaded;
        emit(TeleCrmLoaded(
          leads: filteredLeads,
          calls: currentState.calls,
          stats: currentState.stats,
        ));
      }
    } catch (e) {
      emit(TeleCrmError(message: e.toString()));
    }
  }
}
