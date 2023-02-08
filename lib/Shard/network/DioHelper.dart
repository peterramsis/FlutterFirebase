import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
   static late Dio dio;

  static init(){
    BaseOptions options = BaseOptions(
      baseUrl: 'https://ewdnew.peterramsis.com/api',
      receiveDataWhenStatusError: true,
      followRedirects: false,
      // will not throw errors
      validateStatus: (status) => true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);

  }

  static Future<Response> postData({required String path ,
    required Map<String, dynamic> data ,
    Map<String,dynamic>? query,
    String? token, String? lan})
  {

      return dio.post(path,data: data ,queryParameters: query ,options: Options(
          headers: {
            'Authorization': 'Bearer $token??',
            'Content-Type': 'application/json',
            'Accept'  : 'application/json',
            'lan'     : '$lan'
          }
      ));

  }

  static Future<Response> putData({required String? path ,
    required Map<String, dynamic>? data ,
    Map<String,dynamic>? query,
    String? lan,
    String? token})
  {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          // Do stuff here
          handler.reject(error); // Added this line to let error propagate outside the interceptor
        },
      ),
    );
    return dio.put(path!,data: data ,queryParameters: query ,options: Options(
        headers: {
          'Authorization': 'Bearer $token??',
          'Content-Type': 'application/json',
          'Accept'  : 'application/json',
          'lan'     : '$lan'
        }
    ));
  }

  static Future<Response> getData({required String path , Map<String , dynamic>? query ,String? token , String? lan}) async{
    // print('${'Authorization :'}${'Bearer $token??'}');
    return await dio.get(path,queryParameters: query ,options: Options(
        headers: {
          'Authorization': 'Bearer $token??',
          'Content-Type': 'application/json',
          'Accept'  : 'application/json',
          'lan'     : '$lan'
        }
    ));
  }


   static Future<Response> downloadFile({required String path , savePath, Map<String , dynamic>? query ,String? token}) async{
     return await dio.download(path, savePath,options: Options(
         headers: {
           'Authorization': 'Bearer $token??',
           'Content-Type': 'application/json',
           'Accept'  : 'application/json',
         }
     ));
   }


}