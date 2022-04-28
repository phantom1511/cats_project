import 'dart:async';
import 'dart:io';

import 'package:cats_project/model/cats.dart';
import 'package:cats_project/utils/debugging_util.dart';
import 'package:cats_project/utils/hive_boxes.dart';
import 'package:cats_project/view_model/cat_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'model/cats.g.dart';
import 'service/web_service.dart';
import 'view/cat_main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CatAdapter());
  await Hive.openBox<dynamic>(HiveBoxes.fact);
  runApp(const MyApp());

  final Dio _dio = Dio()
    ..options.baseUrl = 'https://cat-fact.herokuapp.com'
    ..options.headers = {'Accept': 'application/json'}
    ..options.followRedirects = false;

  GetIt.I.registerSingleton<Dio>(_dio);
  GetIt.I.registerSingleton<WebService>(WebService());

  // runZonedGuarded(
  //       () {
  //     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //         .then((_) {
  //       runApp(Phoenix(
  //         child: MultiProvider(providers: [
  //           ListenableProvider(create: (_) => CatProvider()),
  //         ]),
  //       ));
  //     });
  //   },
  //       (error, stack) {
  //     dPrint('$error  $stack', 'Whoops : ');
  //     // Whenever an error occurs, call the `reportCrash`
  //     // to send Dart errors to Crashlytics
  //     //FirebaseCrashlytics.instance.recordError(error, stack);
  //   },
  // );
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
