import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/provider/camera_provider.dart';

class CaptureCameraImageScreen extends ConsumerWidget {
  const CaptureCameraImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraState = ref.watch(cameraProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Capture Image')),
      body: Center(
        child: cameraState.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('Error: $error'),
          data: (controller) => Material(
            color: Colors.white,
            child: InkWell(
              onLongPress: () async {
                final picture = await ref.read(cameraProvider.notifier).takePicture();
                if (picture != null) {
                  Navigator.pop(context, picture.path);
                }
              },
              child: CameraPreview(controller),
            ),
          ),
        ),
      ),
    );
  }
}


/*
class CaptureCameraImageScreen extends StatefulWidget {
  const CaptureCameraImageScreen({super.key});

  @override
  State<CaptureCameraImageScreen> createState() => _CaptureCameraImageScreenState();
}

class _CaptureCameraImageScreenState extends State<CaptureCameraImageScreen> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      CameraDescription availableCamera = (await availableCameras()).firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
      _controller = CameraController(availableCamera, ResolutionPreset.max);
      await _controller?.initialize();
      setState(() {});
    } catch (e) {
      log('Error initializing camera: $e');
    }
  }

  Future<void> _takePicture() async {
    final XFile picture = await _controller!.takePicture();
    Navigator.pop(context, picture.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capture Image')),
      body: Center(
        child: (!(_controller?.value.isInitialized ?? false))
          ? const CircularProgressIndicator()
          : Material(
            color: Colors.white,
            child: InkWell(
              onLongPress: _takePicture,
              child: CameraPreview(_controller!)
            )
        ),
    ));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
*/
