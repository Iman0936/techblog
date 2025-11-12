import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart'as dio_service;
import 'dart:convert';

class DioService {
  Dio dio = Dio();

  Future<Response> getMethod(String url) async {
    try {
      // اصلاح: dio.get نه within
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.plain, method: 'GET'),
      );

      String body = response.data.toString();

      // فقط اگر شامل Warning باشه و [ داشته باشه، تمیز کن
      if (body.contains('Warning') && body.contains('[')) {
        int startIndex = body.indexOf('[');
        if (startIndex != -1) {
          String cleanJson = body.substring(startIndex);

          try {
            final List<dynamic> parsedList = jsonDecode(cleanJson);
            response.data = parsedList; // جایگزین کردن data
            log('Cleaned JSON: ${parsedList.length} items');
          } catch (e) {
            log('JSON Parse Failed: $e');
            response.data = [];
          }
        } else {
          response.data = [];
        }
      } else {
        // اگر Warning ند{$e} نداره، سعی کن پارس کنی
        try {
          response.data = jsonDecode(body);
        } catch (e) {
          // اگر JSON نیست، همون متن خام رو نگه دار
        }
      }

      return response;
    } on DioException catch (e) {
      log('Dio Error: ${e.message}');
      return e.response ??
          Response(
            requestOptions: RequestOptions(path: url),
            data: [],
            statusCode: e.response?.statusCode ?? 500,
          );
    } catch (e) {
      log('Unexpected Error: $e');
      return Response(
        requestOptions: RequestOptions(path: url),
        data: [],
        statusCode: 500,
      );
    }
  }

  Future<dynamic> postMethod(Map<String,dynamic> map,String url)async{
    dio.options.headers['content-Type']='application/json';
    return await dio.post(url,data: dio_service.FormData.fromMap(map),options: Options(
      responseType: ResponseType.json,
      method: 'POST'
    )).then((value) {
      log(value.headers.toString());
      log(value.data.toString());
      log(value.statusCode.toString());
      return value;
    },);

  }
}
