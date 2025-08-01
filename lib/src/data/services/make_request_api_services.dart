import '../../app/app.dart';

class MakeRequestApiServices {
  final NetworkServices networkService;
  MakeRequestApiServices({required this.networkService});

  Future<GenericResponse> getRequestList(Map<String, dynamic> data) async {
    try {
      var response = await networkService.post(
        path: AppUrls.getGuestRequestList,
        data: data,
      );
      return GenericResponse.fromJson(response);
    } catch (e) {
      LogHelper.log('MakeRequestApiServices : getRequestList : Error : $e');
      rethrow;
    }
  }

  Future<GenericResponse> getGuestRequestList(Map<String, dynamic> data) async {
    try {
      var response = await networkService.post(
        path: AppUrls.getMakeRequestGuestRequestList,
        data: data,
      );
      return GenericResponse.fromJson(response);
    } catch (e) {
      LogHelper.log('MakeRequestApiServices : getGuestRequestList : Error : $e');
      rethrow;
    }
  }

  Future<GenericResponse> createRequest(dynamic data) async {
    try {
      var response = await networkService.post(
        path: AppUrls.guestCreateRequest,
        data: data,
      );
      return GenericResponse.fromJson(response);
    } catch (e) {
      LogHelper.log('MakeRequestApiServices : createRequest : Error : $e');
      rethrow;
    }
  }

  Future<GenericResponse> createRequestGuest(dynamic data) async {
    try {
      var response = await networkService.post(
        path: AppUrls.submitMakeRequestGuest,
        data: data,
      );
      return GenericResponse.fromJson(response);
    } catch (e) {
      LogHelper.log('MakeRequestApiServices : createRequestGuest : Error : $e');
      rethrow;
    }
  }

  Future<GenericResponse> getCreateRequestGuestCategoryDataList(Map<String, dynamic> data) async {
    try {
      var response = await networkService.post(
        path: AppUrls.getMakeRequestGuestCategoriesList,
        data: data,
      );
      return GenericResponse.fromJson(response);
    } catch (e) {
      LogHelper.log('MakeRequestApiServices : getCreateRequestGuestCategoryDataList : Error : $e');
      rethrow;
    }
  }

  Future<GenericResponse> getCreateRequestGuestCategoryTypeDataList(Map<String, dynamic> data) async {
    try {
      var response = await networkService.post(
        path: AppUrls.getMakeRequestGuestCategoriesTypesList,
        data: data,
      );
      return GenericResponse.fromJson(response);
    } catch (e) {
      LogHelper.log('MakeRequestApiServices : getCreateRequestGuestCategoryTypeDataList : Error : $e');
      rethrow;
    }
  }
}
