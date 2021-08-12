import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.indigo[200],Colors.tealAccent[100]])),
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.indigoAccent,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}