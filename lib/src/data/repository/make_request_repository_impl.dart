import '../../app/app.dart';

class MakeRequestRepositoryImpl implements MakeRequestRepository {
  final MakeRequestApiServices apiService;
  MakeRequestRepositoryImpl({required this.apiService});

  Future getRequestList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apiService.getRequestList(data);

      if (response.success == 1) {
        response = response.copyWith(
          data: (
            RequestDetails.listFromJson(response.data),
            PaginationDetails.fromJson(response.data['pagination']),
          ),
        );
      }

      return response;
    } catch (e) {
      LogHelper.log('MakeRequestRepositoryImpl : getRequestList : Error : $e');
      rethrow;
    }
  }

  Future getGuestRequestList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apiService.getGuestRequestList(data);

      if (response.success == 1) {
        response = response.copyWith(
          data: (
            GuestRequestDetails.listFromJson(response.data),
            PaginationDetails.fromJson(response.data['details']['pagination']),
          ),
        );
      }

      return response;
    } catch (e) {
      LogHelper.log('MakeRequestRepositoryImpl : getGuestRequestList : Error : $e');
      rethrow;
    }
  }

  Future createRequest(dynamic data) async {
    try {
      GenericResponse response = await apiService.createRequest(data);
      return response;
    } catch (e) {
      LogHelper.log('MakeRequestRepositoryImpl : createRequest : Error : $e');
      rethrow;
    }
  }

  Future createRequestGuest(dynamic data) async {
    try {
      GenericResponse response = await apiService.createRequestGuest(data);
      return response;
    } catch (e) {
      LogHelper.log('MakeRequestRepositoryImpl : createRequestGuest : Error : $e');
      rethrow;
    }
  }

  Future getCreateRequestGuestCategoryDataList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apiService.getCreateRequestGuestCategoryDataList(data);

      if (response.success == 1) {
        response = response.copyWith(
          data: (
            MakeRequestGuest.listFromJson(response.data),
            MakeRequestGuestCategory.listFromJson(response.data),
          ),
        );
      }
      return response;
    } catch (e) {
      LogHelper.log('MakeRequestRepositoryImpl : getCreateRequestGuestCategoryDataList : Error : $e');
      rethrow;
    }
  }

  Future getCreateRequestGuestCategoryTypeDataList(Map<String, dynamic> data) async {
    try {
      GenericResponse response = await apiService.getCreateRequestGuestCategoryTypeDataList(data);

      if (response.success == 1) {
        response = response.copyWith(
          data: MakeRequestGuestCategoryType.listFromJson(response.data),
        );
      }
      return response;
    } catch (e) {
      LogHelper.log('MakeRequestRepositoryImpl : getCreateRequestGuestCategoryTypeDataList : Error : $e');
      rethrow;
    }
  }
}
