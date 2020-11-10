import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterAcmFall/screens/group/group_create_screen.dart';
import 'package:flutterAcmFall/screens/group/group_join_screen.dart';

class GroupEnterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: _helloText(context),
              ),
              SizedBox(height: 50),
              _createGroupButton(context),
              SizedBox(height: 20),
              _joinGroupButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _helloText(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 18,
          color: Colors.black
        ),
        children: <TextSpan>[
          TextSpan(text: 'Hello '),
          TextSpan(text: 'User', style: TextStyle(fontWeight: FontWeight.bold)), // TODO: change User to username
          TextSpan(text: ', please create a group or join an exist one!'),
        ],
      ),
    );
  }

  Widget _createGroupButton(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GroupCreateScreen()),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Create a group',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _joinGroupButton(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GroupJoinScreen()),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Join a group',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
