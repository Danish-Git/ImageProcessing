import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/provider/image_provider.dart';

class ImageSelectionScreen extends ConsumerWidget {
  ImageSelectionScreen({super.key});

  final List<String> assetImagePaths = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Request permissions when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(imageProvider.notifier).initialize();
    });

    final state = ref.watch(imageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Image Selection')),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Gallery Image
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () => _showAssetImages(context, ref),
                  child: Container(
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: state.galleryImage == null
                        ? const Center(child: Text('Tap to Select background image'))
                        : Image.file(state.galleryImage!),
                  ),
                ),
              ),
              // Camera Image
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () => ref.read(imageProvider.notifier).getImageFromCamera(context),
                  child: Container(
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    child: state.cameraImage == null
                        ? const Center(child: Text('Tap to Capture foreground image'))
                        : Image.file(state.cameraImage!),
                  ),
                ),
              ),
            ],
          ),
          if(state.mergingStatus != MergingStatus.idle)
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.grey.withOpacity(0.6),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CircularProgressIndicator(),
                  ),
                  if (state.mergingStatus == MergingStatus.loading)
                    const Text("Initializing...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  if (state.mergingStatus == MergingStatus.resizing)
                    const Text("Resizing images...",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  if (state.mergingStatus == MergingStatus.merging)
                    const Text("Merging images...",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  if (state.mergingStatus == MergingStatus.error)
                    const Text("Error merging images!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.red)),
                  if (state.mergingStatus == MergingStatus.completed)
                    const Text("Images merged successfully!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.green)),
                ]
              )
            ),

        ],
      ),
      floatingActionButton: ((state.cameraImage != null && state.galleryImage != null))
          ? FloatingActionButton(
            backgroundColor: (state.mergingStatus != MergingStatus.idle) ? Colors.grey : Colors.red,
            onPressed: (state.mergingStatus != MergingStatus.idle) ? null : () => ref.read(imageProvider.notifier).mergeImages(context),
            child: const Icon(Icons.merge_type),
          )
          : null,
    );
  }

  void _showAssetImages(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Select Backgroung Image",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.black, size: 25,)),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                  itemCount: assetImagePaths.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Material(
                        color: Colors.grey,
                        child: InkWell(
                          onTap: () => ref.read(imageProvider.notifier).getImageFromGallery(context),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_library_outlined, size: 60),
                              Text("Pick From Gallery", style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () => ref.read(imageProvider.notifier).getImageFromAssets(context, assetImagePaths[index - 1]),
                        child: Image.asset(assetImagePaths[index - 1], fit: BoxFit.cover),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
