import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

void dPrint(Object object, [dynamic tag, bool? isJson]) {
  if (kReleaseMode) return;

  if (isJson ?? false) {
    const encoder = JsonEncoder.withIndent('  ');

    String prettyprint = encoder.convert(object);

    log('${tag ?? ''} $prettyprint');
  } else {
    // print('${tag != null ? tag : ''} ${StackTrace.current}');

    var temp = object;

    if (kDebugMode) {
      print('${tag ?? ''} $temp');
    }
    // ${StackTrace.current}
  }
}
