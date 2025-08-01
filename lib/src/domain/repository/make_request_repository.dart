import '../../app/app.dart';

abstract class MakeRequestRepository {
  Future getRequestList(Map<String, dynamic> data);
  Future getGuestRequestList(Map<String, dynamic> data);
  Future createRequest(dynamic data);
  Future createRequestGuest(dynamic data);
  Future getCreateRequestGuestCategoryDataList(Map<String, dynamic> data);
  Future getCreateRequestGuestCategoryTypeDataList(Map<String, dynamic> data);
}
