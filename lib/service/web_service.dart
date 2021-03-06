import 'package:cats_project/utils/debugging_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../model/cats.dart';

class WebService {
  static final WebService _singleton = WebService._internal();

  factory WebService() {
    return _singleton;
  }

  WebService._internal();

  Dio _dio = GetIt.instance.get<Dio>();

  void updateDio(Dio dio) {
    _dio = dio;
  }

  Future<Cat> getCatFact() async {
    try {
      final response = await _dio.get('https://cat-fact.herokuapp.com/facts/random');
      if (kDebugMode) {
        print('response.data');
        print(response.data);
      }
      return Cat.fromJson(response.data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }
  Future<void> getCatImage() async {
    try {
      final response = await _dio.get('https://cataas.com/cat');
      if (kDebugMode) {
        print(response.data);
      }
      return response.data;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }

}