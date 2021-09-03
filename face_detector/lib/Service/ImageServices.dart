import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as Im;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

//vscode-fold=2

class ImageServices {
  final ImagePicker imagePicker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> takePicture(int option) async {
    final String tempPath = (await getTemporaryDirectory()).path;
    XFile? picX =
        await imagePicker.pickImage(source: (option == 0) ? ImageSource.camera : ImageSource.gallery);
    if (picX != null) {
      File picXFile = File(picX.path);
      Im.Image? decodedImage = Im.decodeImage(picXFile.readAsBytesSync());
      if (decodedImage != null) {
        Im.Image reduced = Im.copyResize(decodedImage, height: 500);
        List<int> encodedImage = Im.encodeJpg(reduced);
        String randomName = [for (int i = 0; i < 20; i++) Random().nextInt(10)].join();
        File reducedFile = File('$tempPath/$randomName.jpg')..writeAsBytesSync(encodedImage);
        UploadTask task = storage.ref().child('$randomName.jpg').putFile(reducedFile);
        String fileName = (await task).ref.name;
        print(fileName);
        String filrUrl = 'http://faceblur-7bd98.appspot.com.storage.googleapis.com/' + fileName;
        return filrUrl;
      }
    }
  }

  Future<File?> hey() async {
    var client = new http.Client();
    var uri = Uri.parse("https://faceblur-jirapit.deta.dev/");
    try {
      var resp = await client.get(uri);
      if (resp.statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY  : ${resp.body}");
      }
    } catch (e) {
      print("EXCEPTION OCCURRED: $e");
      return null;
    }
    return null;
  }

  Future<ImageProvider?> detectFace(String fileUrl) async {
    var client = new http.Client();
    // ignore: non_constant_identifier_names
    String newFileUrl = fileUrl.replaceAll('/', '____').replaceAll('http', 'jirachayanid');
    var uri = Uri.parse("https://faceblur-jirapit.deta.dev/detect/" + newFileUrl);
    try {
      var resp = await client.get(uri);
      print("DATA FETCHED SUCCESSFULLY");

      String base64string = resp.body.substring(1, resp.body.length - 2);
      int base64stringLengh = base64string.length;
      if (base64stringLengh % 4 != 0) {
        base64string = base64string + [for (int i = 0; i < 4 - (base64stringLengh % 4); i++) '='].join();
      }
      print(base64string.length);
      Uint8List pic = base64.decode(base64string);
      var image = MemoryImage(pic);
      return image;
    } catch (e) {
      print("EXCEPTION OCCURRED: $e");
      return null;
    }
  }
}
