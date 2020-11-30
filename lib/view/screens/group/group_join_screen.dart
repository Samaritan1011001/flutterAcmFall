import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterAcmFall/model/auth_model.dart';
import 'package:flutterAcmFall/main.dart';

class GroupJoinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create you group"),
      ),
      body: JoinGroupForm(),
    );
  }
}

class JoinGroupForm extends StatefulWidget {
  @override
  JoinGroupFormState createState() {
    return JoinGroupFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class JoinGroupFormState extends State<JoinGroupForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<CreateGroupFormState>.
  final _formKey = GlobalKey<FormState>();
  final keyController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: keyController,
            decoration: const InputDecoration(
              hintText: 'Enter your group key',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid
                if (_formKey.currentState.validate()) {
                  firestoreInstance
                      .collection("groups")
                      .doc(keyController.text)
                      .get()
                      .then((res) {
                    if (res.exists) {
                      User currentUser =
                          Provider.of<AuthModel>(context, listen: false)
                              .getUser();
                      firestoreInstance
                          .collection("users")
                          .doc(currentUser.uid)
                          .update({"group": keyController.text}).then((_) {
                        firestoreInstance
                            .collection("groups")
                            .doc(keyController.text)
                            .update({
                          "users": FieldValue.arrayUnion([currentUser.uid])
                        }).then((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp()),
                          );
                        });
                      });
                    } else {
                      // TODO: non exist group key
                    }
                  });
                }
              },
              child: Text('Join'),
            ),
          ),
        ],
      ),
    );
  }
}
