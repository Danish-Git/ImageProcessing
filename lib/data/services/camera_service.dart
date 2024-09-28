import 'package:camera/camera.dart';

import '../repositories/camera_repository.dart';

class CameraService {
  final CameraRepository repository;

  CameraService(this.repository);

  Future<CameraController> initializeCamera() async {
    final camera = await repository.getFrontCamera();
    final controller = CameraController(camera, ResolutionPreset.max);
    await controller.initialize();
    return controller;
  }
}
