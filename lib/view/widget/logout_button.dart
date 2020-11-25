import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterAcmFall/model/auth_model.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: const Icon(Icons.logout, color: Colors.black),
      tooltip: 'Logout',
      onPressed: () async {
        await Provider.of<AuthModel>(context, listen: false).signOutGoogle();
      },
    );
  }
}
