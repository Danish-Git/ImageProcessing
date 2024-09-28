import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<bool> checkPermissions() async {
    final cameraGranted = await Permission.camera.isGranted;
    final storageGranted = await Permission.storage.isGranted;
    return cameraGranted && storageGranted;
  }
}
