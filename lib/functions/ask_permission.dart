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
    }

    return allowed;
  }

  _askPermissoon() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.location]).then(_onStatusRequested);
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      _status = status;
      if (_status == PermissionStatus.granted) {
        allowed = true;
      }
    }
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.locationWhenInUse];
    _updateStatus(status);
  }
}
