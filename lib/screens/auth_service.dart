import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> getUser() async {
    return _auth.currentUser;
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    var result = await FirebaseAuth.instance.signInWithCredential(credential);
    final User user = result.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      FirebaseFirestore.instance.collection("users").doc(user.uid).set(
      {
        "username" : user.displayName,
        "email:" : user.email,
      },SetOptions(merge: true)).then((_){
        print("Create user in firestore success!");
      });

      notifyListeners();
      return user;
    }

    return null;
  }

  Future signOutGoogle() async {
    var result = FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    notifyListeners();
    return result;
  }
}
