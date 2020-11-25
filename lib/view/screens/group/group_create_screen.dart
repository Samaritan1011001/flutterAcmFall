import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterAcmFall/model/auth_model.dart';
import 'package:flutterAcmFall/main.dart';

class GroupCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create you group"),
      ),
      body: CreateGroupForm(),
    );
  }
}

class CreateGroupForm extends StatefulWidget {
  @override
  CreateGroupFormState createState() {
    return CreateGroupFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CreateGroupFormState extends State<CreateGroupForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<CreateGroupFormState>.
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
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
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Enter your group name',
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
                  firestoreInstance.collection("groups").add({
                    "name": nameController.text,
                  }).then((res) {
                    User currentUser =
                        Provider.of<AuthModel>(context, listen: false)
                            .getUser();
                    firestoreInstance
                        .collection("users")
                        .doc(currentUser.uid)
                        .update({"group": res.id}).then((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    });
                  });
                }
              },
              child: Text('Create'),
            ),
          ),
        ],
      ),
    );
  }
}
