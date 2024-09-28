import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import '../repositories/camera_repository.dart';
import '../services/camera_service.dart';

final cameraProvider = StateNotifierProvider<CameraControllerNotifier, AsyncValue<CameraController>>((ref) {
  final cameraService = CameraService(CameraRepository());
  return CameraControllerNotifier(cameraService);
});

class CameraControllerNotifier extends StateNotifier<AsyncValue<CameraController>> {
  final CameraService cameraService;

  CameraControllerNotifier(this.cameraService) : super(const AsyncValue.loading()) {
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final controller = await cameraService.initializeCamera();
      state = AsyncValue.data(controller);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<XFile?> takePicture() async {
    if (state.hasValue) {
      return await state.value!.takePicture();
    }
    return null;
  }
}
