import 'package:face_detector/Screen/LoadingIndicatorScreen.dart';
import 'package:face_detector/Screen/ShowImageScreen.dart';
import 'package:face_detector/Service/ImageServices.dart';
import 'package:face_detector/Service/LocalDataManager.dart';
import 'package:face_detector/Template/WidgetTemplate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//vscode-fold=2

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Face?...Blur!',
                  style: GoogleFonts.pacifico(
                    color: Colors.yellow[900],
                    fontWeight: FontWeight.normal,
                    fontSize: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: Divider(
                    color: Colors.yellow[900],
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Provider.of<LocalDataManager>(context, listen: false).setLoading(set: true);
                        // ignore: non_constant_identifier_names
                        String? fileUrl = await ImageServices().takePicture(0);
                        if (fileUrl != null) {
                          // ignore: unused_local_variable
                          ImageProvider? imageFile = await ImageServices().detectFace(fileUrl);
                          if (imageFile != null) {
                            Provider.of<LocalDataManager>(context, listen: false).setLoading(set: false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowImageScreen(imageFile: imageFile)));
                          }
                        }
                        Provider.of<LocalDataManager>(context, listen: false).setLoading(set: false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                          boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 2)],
                          color: Colors.yellow[900],
                        ),
                        width: 150,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 100,
                                color: Colors.white,
                              ),
                              Center(
                                child: Text(
                                  'Camera',
                                  style: whiteText(fontWeight: FontWeight.normal, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Provider.of<LocalDataManager>(context, listen: false).setLoading(set: true);
                        // ignore: non_constant_identifier_names
                        String? fileUrl = await ImageServices().takePicture(1);
                        if (fileUrl != null) {
                          // ignore: unused_local_variable
                          ImageProvider? imageFile = await ImageServices().detectFace(fileUrl);
                          if (imageFile != null) {
                            Provider.of<LocalDataManager>(context, listen: false).setLoading(set: false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowImageScreen(imageFile: imageFile)));
                          }
                        }
                        Provider.of<LocalDataManager>(context, listen: false).setLoading(set: false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                          boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(0, 2), blurRadius: 2)],
                          color: Colors.yellow[900],
                        ),
                        width: 150,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: 100,
                                color: Colors.white,
                              ),
                              Center(
                                child: Text(
                                  'Gallery',
                                  style: whiteText(fontWeight: FontWeight.normal, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        (Provider.of<LocalDataManager>(context).isLoading) ? LoadingIndicatorScreen() : Center()
      ],
    );
  }
}
