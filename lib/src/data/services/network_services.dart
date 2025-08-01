import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../main.dart';
import '../../app/app.dart';

class NetworkServices {
  late Dio _dio;

  bool getNetworkStatus() => getIt<AppBloc>().isConnected;

  Future<String?> getIpAddress() async {
    try {
      final String ipAddress = await Ipify.ipv4().timeout(Duration(seconds: 1));
      return ipAddress;
    } catch (e) {
      LogHelper.log('NetworkServices Error : getIpAddress :$e');
      return null;
    }
  }

  Future<void> prepareRequest() async {
    String baseUrlApp = AppUrls.baseUrlApp;
    LogHelper.log('BaseUrlApp : $baseUrlApp');

    // MARK: API endpoint setting
    BaseOptions dioOptions = BaseOptions(
      baseUrl: baseUrlApp ,
      contentType: Headers.jsonContentType,
      headers: {'Accept': Headers.jsonContentType},
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
       validateStatus: (status) {
    return status != null && status >= 200 && status < 500;
  },
    );

    _dio = Dio(dioOptions);
    _dio.interceptors.clear();
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      )
    ]);
   
  }

  Future<Uint8List> getImageBytes(String imageUrl) async {
    var response = await Dio().get<Uint8List>(
      imageUrl,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    return response.data!;
  }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
      );
      return response.data;
    } on Exception catch (exception) {
      return ExceptionHandler.handleError(exception);
    }
  }

  Future<dynamic> post({
    required String path,
    String? token,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    dynamic data,
    bool hideLog = false,
  }) async {
    

    try {
      bool isConnected = getNetworkStatus();
      if (isConnected) {
       final response = await _dio.post(
          path,
          queryParameters: query,
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer ',
              ...?header,
            },
          ),
        );
      

        log(jsonEncode(response.data),name: path);

        return response.data;
      } else {
        return {'error_code': 000, 'error_msg': 'No Internet'};
      }
    } on Exception catch (error) {
      throw ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: query,
        data: data,
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        queryParameters: query,
        data: data,
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: query,
        data: data,
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> postFormData({
    required String path,
    Map<String, dynamic>? query,
    FormData? data,
  }) async {
    try {
  
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer '},
        ),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> postServerNotification({
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    try {
      bool isConnected = getNetworkStatus();
      if (isConnected) {
        final response = await _dio.post(
          AppUrls.sendServerNotification,
          queryParameters: query,
          data: data,
        );

        return response.data;
      } else {
        return {'error_code': 000, 'error_msg': 'No Internet'};
      }
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> postFirebaseNotification({
    dynamic data,
    String? token,
  }) async {
    try {
      bool isConnected = getNetworkStatus();
      if (isConnected) {
        final response = await _dio.post(
          AppUrls.sendFirebaseNotification,
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
        return response.data;
      } else {
        return {'error_code': 000, 'error_msg': 'No Internet'};
      }
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }
}
