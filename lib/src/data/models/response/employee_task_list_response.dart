import '../../../app/app.dart';

class EmployeeTaskListResponse {
  final List<EmployeeTaskDetails?>? tasksList;
  final List<TaskChipInfo?>? taskStatusChipList;
  final List<TaskChipInfo?>? taskStepsChipList;

  EmployeeTaskListResponse({
    this.tasksList,
    this.taskStatusChipList,
    this.taskStepsChipList,
  });
}
