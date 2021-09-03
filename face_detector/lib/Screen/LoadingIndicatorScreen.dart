import 'package:flutter_spinkit/flutter_spinkit.dart' as spin;
import 'package:flutter/material.dart';

class LoadingIndicatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xCCBBFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 18,
            ),
            spin.SpinKitCubeGrid(
              color: Colors.yellow[900],
              size: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Analyzing Image',
              style: TextStyle(
                color: Colors.yellow[900],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
