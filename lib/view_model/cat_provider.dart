//
// import 'package:cats_project/model/cats.dart';
// import 'package:flutter/material.dart';
//
// import '../service/web_service.dart';
// import '../utils/debugging_util.dart';
//
// class CatProvider extends ChangeNotifier {
//   Cat _cat = [];
//   final webService = WebService();
//
//   Cat get cats => _cat;
//
//   Future<void> fetchCatFact() async {
//     try {
//       _cat = await webService.getCatFact();
//       notifyListeners();
//     } on Exception catch (e) {
//       dPrint(e);
//     }
//   }
// }