import 'package:flutter/material.dart';
import 'dart:io';

class MergedImageScreen extends StatelessWidget {
  final File mergedImageFile;

  const MergedImageScreen({super.key, required this.mergedImageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Merged Image')),
      body: Center(
        child: Image.file(mergedImageFile),
      ),
    );
  }
}
