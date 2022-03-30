import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:jsondemoproject/network/dio_exception.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */

class CommonException {
  showException(BuildContext context, Object obj) {
    DioException().getDioException(context, obj);
    final res = (obj as DioError).response;

    if (kDebugMode) {
      print(res);
    }
  }

  /*use for non alert msg*/
  exception(BuildContext context, Object obj) {
    if (context != null) {
      DioException().getDioException(context, obj);
      final res = (obj as DioError).response;
      if (kDebugMode) {
        print(res);
      }
    }
  }
}
