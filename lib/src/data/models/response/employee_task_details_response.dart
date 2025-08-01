import '../../../app/app.dart';

class EmployeeTaskDetailsResponse {
  final EmployeeTaskDetails? taskDetails;
  final List<TaskChipInfo?>? taskStatusChipList;
  final List<TaskChipInfo?>? taskStepsChipList;

  EmployeeTaskDetailsResponse({
    this.taskDetails,
    this.taskStatusChipList,
    this.taskStepsChipList,
  });
}
