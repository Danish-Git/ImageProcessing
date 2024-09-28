import 'dart:io';
import 'package:image/image.dart' as img;

import '../data/repositories/image_repository.dart';

class ImageUseCase {
  final ImageRepository repository;

  ImageUseCase(this.repository);

  Future<img.Image> resizeImage(img.Image imageFile, int width, int height) {
    return repository.resizeImage(imageFile, width, height);
  }

  Future<img.Image?> decodeImage(File imageFile) {
    return repository.decodeImage(imageFile);
  }

  Future<File> mergeImages(img.Image? cameraImage, img.Image? galleryImage) {
    return repository.mergeImages(cameraImage, galleryImage);
  }
}
