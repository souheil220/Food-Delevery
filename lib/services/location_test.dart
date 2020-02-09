
import 'package:geolocator/geolocator.dart';

class LocationTest{
  LocationTest();
  checkLocation()async{
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    bool geolocationStatus  = await geolocator.isLocationServiceEnabled();
    return geolocationStatus;
    }
  
}