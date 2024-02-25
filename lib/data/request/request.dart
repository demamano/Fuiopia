import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fuiopia/constants/key_constant.dart';
import 'package:fuiopia/data/models/error_model.dart';
import 'package:fuiopia/data/request/api_url.dart';
import 'package:fuiopia/utils/logger.dart';

Map<MethodType, String> methods = {
  MethodType.GET: "GET",
  MethodType.POST: "POST"
};

class Request {
  Dio _dio = Dio();

  Request({required String baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: Duration(microseconds: environment.receiveTimeout),
      connectTimeout: Duration(microseconds: environment.connectTimeout),
      contentType: "application/json",
    ));
  }

  Future<Object> requestApi(
      {required MethodType method,
      required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? header}) async {
    Logger.info("URL: $url\nbody: $data");
    try {
      var response = await _dio.request(
        url,
        data: data,
        options: Options(method: methods[method], headers: header),
      );

      return response.data;
    } catch (e) {
      Logger.error(e.toString());
      return handleError(e);
    }
  }

  Future<ErrorModel> handleError(dynamic error) async {
    ErrorModel errorModel = ErrorModel();
    errorModel.message = error.toString();
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.sendTimeout:
          errorModel.description = KEY_CONST.request_send_timeout;
          break;
        case DioExceptionType.cancel:
          errorModel.description = KEY_CONST.request_cancelled;
          break;
        case DioExceptionType.connectionTimeout:
          errorModel.description = KEY_CONST.request_connect_timeout;
          break;
        case DioExceptionType.connectionError:
          errorModel.description = KEY_CONST.no_internet;
          break;
        case DioExceptionType.receiveTimeout:
          errorModel.description = KEY_CONST.request_receive_timeout;
          break;
        case DioExceptionType.badResponse:
          Logger.error(error.response!.toString());
          try {
            errorModel.code = error.response?.statusCode ?? errorModel.code;
            errorModel.description =
                error.response?.data ?? errorModel.description;
          } catch (e) {
            Logger.error(e.toString());
          }
          break;
        case DioExceptionType.badCertificate:
          break;
        case DioExceptionType.unknown:
          break;
      }
    }
    return errorModel;
  }
}
