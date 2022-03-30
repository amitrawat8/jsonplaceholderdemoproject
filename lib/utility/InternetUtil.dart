import 'package:connectivity_plus/connectivity_plus.dart';

/**
 * Created by Amit Rawat on 3/30/2022.
 */
class InternetUtil {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
