import 'package:jsondemoproject/network/rest_client.dart';

import 'common_dio.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */

class HttpObj {
  HttpObj._privateConstructor();

  static final HttpObj _instance = HttpObj._privateConstructor();

  static HttpObj get instance => _instance;

  static RestClient? client;

  clear() {
    client = null;
  }

  RestClient getClient() {
    if (client == null) {
      client = RestClient(ApiClient.instance.getdio());
    }
    return client!;
  }
}
