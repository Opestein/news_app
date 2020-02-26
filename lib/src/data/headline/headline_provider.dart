import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/src/data/base_url.dart';
import 'package:news_app/src/model/error.dart';
import 'package:news_app/src/model/headline_response.dart';
import 'package:news_app/src/utils/operation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeadlineProvider {
  Future<Operation> getHeadline(
    Dio dio,
  ) async {
    final url = baseUrlV1.replaceAll('url', 'top-headlines?country=us');

    print(url);
    var response = await dio
        .get(
      url,
      options: Options(
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    )
        .timeout(Duration(minutes: 10), onTimeout: () async {
      return Response(
          data: {"message": "Connection Timed out. Please try again"},
          statusCode: 408);
    }).catchError((error) {
      return Response(
          data: {"message": "Error occurred while connecting to server"},
          statusCode: 508);
    });

    if (response.statusCode == 200) {
      final responseJson = response.data;

      var data = HeadlineResponse.fromJson(responseJson);

      return Operation(response.statusCode, data);
    } else {
      var error = ErrorResponse.fromJson(response.data);
      return Operation(response.statusCode, error);
    }
  }
}

final headlineProvider = HeadlineProvider();
