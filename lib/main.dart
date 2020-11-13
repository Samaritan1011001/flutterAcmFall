import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterAcmFall/screens/home_screen.dart';
import 'package:flutterAcmFall/screens/login_page.dart';
import 'package:flutterAcmFall/screens/auth_service.dart';
import 'package:flutterAcmFall/screens/group/group_enter_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<AuthService>(
      child: MyApp(),
      builder: (BuildContext context) {
        return AuthService();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<User>(
        // get the Provider, and call the getUser method
        future: Provider.of<AuthService>(context).checkUser(),
        // wait for the future to resolve and render the appropriate
        // widget for HomePage or LoginPage
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // log error to console
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }

            // redirect to the proper page
            return snapshot.hasData
                ? CheckUserGroup(snapshot.data)
                : LoginPage();
          } else {
            // show loading indicator
            return LoadingCircle();
          }
        },
      ),
    );
  }
}

class CheckUserGroup extends StatelessWidget {
  // navigate to group enter screen if user doesn't have any group
  CheckUserGroup(this._currentUser);
  final User _currentUser;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _userCollection.doc(_currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print("error");
          return Text(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> userdata = snapshot.data.data();
          return userdata.containsKey("group")
              ? HomeScreen()
              : GroupEnterScreen(userdata);
        }
        // show loading indicator
        return LoadingCircle();
      },
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            child: CircularProgressIndicator(),
            alignment: Alignment(0.0, 0.0),
          ),
        ),
      ),
    );
  }
}
