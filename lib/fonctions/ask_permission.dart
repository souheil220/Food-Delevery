import 'package:hello_world/services/currentLocation.dart';
import 'package:hello_world/ui/brew_list.dart';
import 'package:permission_handler/permission_handler.dart';

class AskPermission {
  AskPermission();
  bool allowed = false;
  PermissionStatus _status;

  Future<bool> askForPermission() async {
    await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location)
        .then(_updateStatus);

    if (_status == PermissionStatus.unknown ||
        _status == PermissionStatus.denied ||
        _status == null) {
      await _askPermissoon();
      print('here 4');
    }

    return allowed;
  }

  _askPermissoon() async{
    print('here1');
   await PermissionHandler().requestPermissions([PermissionGroup.location]).then(
        _onStatusRequested);
  }

  void _updateStatus(PermissionStatus status) {
    print('here 3');
    if (status != _status) {
      _status = status;
      if (_status == PermissionStatus.granted) {
        allowed = true;
        print('ggggggggggggggggggggggggggggggggg');
        print(allowed );
        print('ggggggggggggggggggggggggggggggggg');
        

      
      }
    }
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    print('here 2');
    final status = statuses[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
  }
}
