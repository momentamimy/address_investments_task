import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static Future<List<ConnectivityResult>> checkConnectivity() async {
    return await (Connectivity().checkConnectivity());
  }

  static Future<bool> isOnline() async {
    List<ConnectivityResult> result = await checkConnectivity();
    return result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile);
  }
}
