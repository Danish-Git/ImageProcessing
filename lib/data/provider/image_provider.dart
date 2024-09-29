import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';


import '../../data/repositories/image_repository.dart';
import '../../domain/image_use_case.dart';
import '../../presentation/screens/capture_camera_image_screen.dart';
import '../../presentation/screens/merged_image_screen.dart';
import '../services/permission_service.dart';

enum MergingStatus { idle, loading, resizing, merging, completed, error }

final imageProvider = StateNotifierProvider<ImageNotifier, ImageState>((ref) {
  final repository = ImageRepository();
  final useCase = ImageUseCase(repository);
  return ImageNotifier(useCase);
});

class ImageState {
  final File? cameraImage;
  final File? galleryImage;
  final MergingStatus mergingStatus;

  ImageState({
    this.cameraImage,
    this.galleryImage,
    this.mergingStatus = MergingStatus.idle,
  });

  ImageState copyWith({
    File? cameraImage,
    File? galleryImage,
    MergingStatus? mergingStatus,
  }) {
    return ImageState(
      cameraImage: cameraImage ?? this.cameraImage,
      galleryImage: galleryImage ?? this.galleryImage,
      mergingStatus: mergingStatus ?? this.mergingStatus,
    );
  }
}

class ImageNotifier extends StateNotifier<ImageState> {
  final ImageUseCase useCase;

  ImageNotifier(this.useCase) : super(ImageState());

  Future<void> initialize() async {
    final hasPermissions = await requestPermissions();
    if (!hasPermissions) {
      log("Camera and/or storage permissions denied.");
    } else {
      log("Camera and storage permissions granted.");
    }
  }

  Future<bool> requestPermissions() async {
    final cameraGranted = await PermissionService().requestCameraPermission();
    final storageGranted = await PermissionService().requestStoragePermission();
    return cameraGranted && storageGranted;
  }

  Future<void> getImageFromAssets(BuildContext context, String assetImagePath) async {
    if(await requestPermissions()) {
      String fileName = assetImagePath.split("/").last;
      final byteData = await rootBundle.load(assetImagePath);
      final file = File('${(await getTemporaryDirectory()).path}/$fileName');
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      state = state.copyWith(galleryImage: file);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Camera and/or storage permissions denied!'),
      ));
      log("Camera and/or storage permissions denied.");
      Navigator.pop(context);
    }
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    Navigator.pop(context);
    if(await requestPermissions()) {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        state = state.copyWith(galleryImage: File(pickedFile.path));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Camera and/or storage permissions denied!'),
      ));
      log("Camera and/or storage permissions denied.");
    }

  }

  Future<void> getImageFromCamera(BuildContext context) async {
    if(await requestPermissions()) {
      final pickedFile = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CaptureCameraImageScreen())
      );

      if (pickedFile is String) {
        state = state.copyWith(cameraImage: File(pickedFile));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Camera and/or storage permissions denied!'),
      ));
      log("Camera and/or storage permissions denied.");
    }
  }

  Future<void> mergeImages(BuildContext context) async {
    if (state.cameraImage == null || state.galleryImage == null) return;

    state = state.copyWith(mergingStatus: MergingStatus.loading);

    try {
      img.Image? cameraImage = await useCase.decodeImage(state.cameraImage!);
      img.Image? galleryImage = await useCase.decodeImage(state.galleryImage!);

      state = state.copyWith(mergingStatus: MergingStatus.resizing);
      final width1 = cameraImage?.width ?? 1;
      final height1 = cameraImage?.height ?? 1;
      final width2 = galleryImage?.width ?? 1;
      final height2 = galleryImage?.height ?? 1;

      final cameraImageArea = width1 * height1;
      final galleryImageArea = width2 * height2;

      if (cameraImageArea > galleryImageArea) {
        cameraImage = await useCase.resizeImage(cameraImage!, width2, height2);
      } else if (galleryImageArea > cameraImageArea) {
        galleryImage = await useCase.resizeImage(galleryImage!, width1, height1);
      }

      state = state.copyWith(mergingStatus: MergingStatus.merging);
      File mergedFile = await useCase.mergeImages(cameraImage, galleryImage);
      state = state.copyWith(mergingStatus: MergingStatus.completed);
      // Navigate to MergedImageScreen with the merged image file
      await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MergedImageScreen(mergedImageFile: mergedFile)),);

      state = state.copyWith(mergingStatus: MergingStatus.idle);
    } catch (e) {
      state = state.copyWith(mergingStatus: MergingStatus.error);
    }
  }
}
