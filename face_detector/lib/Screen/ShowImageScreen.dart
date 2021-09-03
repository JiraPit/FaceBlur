import 'package:face_detector/Template/WidgetTemplate.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowImageScreen extends StatelessWidget {
  final ImageProvider imageFile;

  ShowImageScreen({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Text(
          'Result',
          style: whiteText(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
      ),
      body: PhotoView(
        imageProvider: imageFile,
      ),
    );
  }
}
