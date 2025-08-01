import '../../../app/app.dart';

class EmployeeTaskStepDetailsResponse {
  final EmployeeTaskStepDetails? taskStepDetails;
  final List<TaskStepCollectAddItemDetails?>? taskStepCollectAddItemDetailsList;
  final List<TaskStepChecklistDetails?>? taskStepChecklistDetailsList;
  final TaskStepRoomStatusDetails? taskStepRoomStatusDetails;
  final List<TaskStepRoomStatusOption?>? taskStepRoomStatusOptionList;
  final List<TaskStepRoomPicturesDetails?>? taskStepRoomPicturesDetailsList;
  final List<TaskStepRoomInspectionDetails?>? taskStepRoomInspectionDetailsList;
  final List<TaskStepRoomProductConditionOption?>? taskStepRoomProductConditionOptionList;

  EmployeeTaskStepDetailsResponse({
    this.taskStepDetails,
    this.taskStepCollectAddItemDetailsList,
    this.taskStepChecklistDetailsList,
    this.taskStepRoomStatusDetails,
    this.taskStepRoomStatusOptionList,
    this.taskStepRoomPicturesDetailsList,
    this.taskStepRoomInspectionDetailsList,
    this.taskStepRoomProductConditionOptionList,
  });
}
