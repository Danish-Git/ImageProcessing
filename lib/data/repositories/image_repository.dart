import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class ImageRepository {

  Future<img.Image> resizeImage(img.Image imageFile, int width, int height) async {
    return copyResize(imageFile, width: width, height: height);
  }

  Future<img.Image?> decodeImage(File imageFile) async {
    return img.decodeImage(await imageFile.readAsBytes());
  }

  Future<File> mergeImages(img.Image? cameraImage, img.Image? galleryImage) async {
    // Merging logic
    int width = ((cameraImage!.width > galleryImage!.width) ? cameraImage.width : galleryImage.width) + 5;
    int height = (cameraImage.height > galleryImage.height) ? cameraImage.height : galleryImage.height;

    img.Image mergedImage = img.Image(width: width, height: height);
    img.compositeImage(mergedImage, galleryImage, dstX: 0, dstH: galleryImage.height, blend: img.BlendMode.direct);
    img.compositeImage(mergedImage, cameraImage, dstX: 0, dstH: cameraImage.height, blend: img.BlendMode.overlay);

    final mergedFile = File('${(await getTemporaryDirectory()).path}/${DateTime.timestamp().toString()}.jpg')
      ..writeAsBytesSync(img.encodeJpg(mergedImage));

    return mergedFile;
  }
}
