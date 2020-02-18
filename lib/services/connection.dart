import 'package:connectivity/connectivity.dart';

class Connection{
  Connection();
 Future<bool> checkInternetConnectivity() async{
    bool connected = false;
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){
          connected = false;
    }
    else{
      connected = true;
    }
  //  print('here $connected');
    return connected;
  }
}