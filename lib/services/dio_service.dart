import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'dart:developer';
import 'package:dio/dio.dart';

class DioService {
  Future<dynamic> getMethod(String url) async {
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(
          url,
          options: Options(responseType: ResponseType.json, method: 'Get'),
        )
        .then((response) {
          return response;
        });
  }
}
