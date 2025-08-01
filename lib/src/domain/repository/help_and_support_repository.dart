abstract class HelpAndSupportRepository {
  Future getFaqsList(Map<String, dynamic> data);
  Future getAccounManagerList(Map<String, dynamic> data);
  Future getRequestCallbackList(Map<String, dynamic> data);
  Future createRequestCallback(Map<String, dynamic> data);
  Future getTutorialsList(Map<String, dynamic> data);
  Future getTutorialDetails(Map<String, dynamic> data);
  Future submitEmailSupportRequest(dynamic data);
}
