part of 'lead_details_bloc.dart';





abstract class LeadDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadLeadDetails extends LeadDetailsEvent {
  final String leadId;
  LoadLeadDetails(this.leadId);
  @override
  List<Object?> get props => [leadId];
}