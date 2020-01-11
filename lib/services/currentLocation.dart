import 'package:geolocator/geolocator.dart';

class CurrentLocation {
  CurrentLocation();

  Future getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position);
    return (position);
  }
}
