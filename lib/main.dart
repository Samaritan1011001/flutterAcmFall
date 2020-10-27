import 'package:flutter/material.dart';
import 'package:flutterAcmFall/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(FireInit());
}

class FireInit extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //return SomethingWentWrong();
          print('Something went wrong in Flutter Fire');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        print('firebase not Init');
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.fromRGBO(34, 36, 49, 1),
          alignment: Alignment.bottomCenter,
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
