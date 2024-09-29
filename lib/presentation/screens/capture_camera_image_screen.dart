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
          data: (controller) => Stack(
            children: [
              Center(
                child: Material(
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
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Long press on camera view to capture image",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
