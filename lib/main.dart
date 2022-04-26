import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'service/web_service.dart';
import 'view/cat_main_page.dart';

void main() {
  runApp(const MyApp());

  final Dio _dio = Dio()
    ..options.baseUrl = 'https://cat-fact.herokuapp.com'
    ..options.headers = {'Accept': 'application/json'}
    ..options.followRedirects = false;

  GetIt.I.registerSingleton<Dio>(_dio);
  GetIt.I.registerSingleton<WebService>(WebService());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CatMainPage(),
    );
  }
}
