abstract class BugReportRepository {
  Future getBugReportedList(Map<String, dynamic> data);
  Future getBugLabelList(Map<String, dynamic> data);
  Future getBugStatusList(Map<String, dynamic> data);
  Future getBugPriorityList(Map<String, dynamic> data);
  Future getBugSeverityList(Map<String, dynamic> data);
  Future getBugDeviceList(Map<String, dynamic> data);
  Future getBugReportDetails(Map<String, dynamic> data);
  Future createBugReport(dynamic data);
  Future createBugFollowUp(dynamic data);
}
