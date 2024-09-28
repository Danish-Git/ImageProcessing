import 'package:camera/camera.dart';

class CameraRepository {
  Future<CameraDescription> getFrontCamera() async {
    final cameras = await availableCameras();
    return cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
  }
}
