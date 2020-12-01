import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterAcmFall/model/objects/AppUser.dart';

typedef void ListCallback(ChecklistModel cm,bool createNew, String gid);

class ChecklistCreationScreen extends StatefulWidget {
  @override
  _ChecklistCreationScreen createState() => _ChecklistCreationScreen(callback: callback, user: user, checklistModel: checklistModel, createNew: createNew);

  final ListCallback callback;
  final AppUser user;
  final ChecklistModel checklistModel;
  final bool createNew;
  final String groceryId;
  ChecklistCreationScreen({this.callback, this.user, this.checklistModel, this.createNew, this.groceryId});
}

class _ChecklistCreationScreen extends State<ChecklistCreationScreen> {
  final firestoreInstance = FirebaseFirestore.instance;
  final ListCallback callback;
  AppUser user;
  bool createNew;

  _ChecklistCreationScreen({this.callback, this.user, this.checklistModel, this.createNew});

  ChecklistModel checklistModel = ChecklistModel(date: DateTime.now(), items: []);

  initState() {
//    user = widget.user;
    if (createNew == true) {
      checklistModel.items.add(ChecklistItemModel(text: "", isChecked: false));
    }

    print("checklistModel : ${checklistModel.items[0].text}");

    super.initState();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leadingWidth: 100,
        leading: Builder(builder: (BuildContext context) {
          return FlatButton(
            textColor: Color.fromRGBO(0, 108, 255, 1),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: new TextStyle(fontSize: 18, fontFamily: 'SFProText', fontWeight: FontWeight.w400),
            ),
          );
        }),
        actions: <Widget>[
          FlatButton(
            textColor: Color.fromRGBO(0, 108, 255, 1),
            onPressed: () {
              if (createNew == true) {
                if (checklistModel.items[0].text.isNotEmpty) {
//                List<Map<String, dynamic>> checkListItems = [];
                  firestoreInstance.collection("groceries").add({
                    "checklist": checklistModel.items.map((e) => e.toJson()).toList(),
                    "date": checklistModel.date,
                    "isActive": true,
                    "isDone": false,
                    "time": checklistModel.date,
                    "user": widget.user.id,
                    "group": widget.user.group
                  });
                }
              } else {
                if (widget.groceryId != null && checklistModel.items[0].text.isNotEmpty)
                  firestoreInstance.collection("groceries").doc(widget.groceryId).set({
                    "checklist": checklistModel.items.map((e) => e.toJson()).toList(),
                    "date": checklistModel.date,
                  }, SetOptions(merge: true));
              }
              callback(checklistModel,createNew,widget.groceryId);

              Navigator.pop(context);
            },
            child: Text(
              "Done",
              style: new TextStyle(fontSize: 18, fontFamily: 'SFProText', fontWeight: FontWeight.w700),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context, showTitleActions: true, minTime: DateTime.now(), maxTime: DateTime(2100, 6, 7), onConfirm: (date) {
                  setState(() {
                    checklistModel.date = date;
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[new Icon(Icons.calendar_today_outlined, color: Color.fromRGBO(135, 135, 135, 1))],
              ),
            ),
            Text(DateFormat('MM/dd/yyyy – kk:mm').format(checklistModel.date))
          ],
        )
      ],
      body: ListView.builder(
          itemCount: checklistModel.items.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
                child: ListTile(
              leading: Checkbox(
                value: checklistModel.items[index].isChecked,
                onChanged: (bool value) {
                  setState(() {
                    checklistModel.items[index].isChecked = value;
                  });
                },
              ),
              title: TextField(
                style: TextStyle(fontFamily: 'SFProText', fontSize: 18, color: Color.fromRGBO(37, 42, 49, 1)),
                onSubmitted: (String input) {
                  setState(() {
                    if (input.isNotEmpty) {
                      checklistModel.items.add(ChecklistItemModel(text: "", isChecked: false));
                    }
                  });
                },
                controller: checklistModel.items[index]._textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What do you want to do?",
                  hintStyle: TextStyle(fontFamily: 'SFProText', fontSize: 18, color: Color.fromRGBO(135, 135, 135, 1)),
                ),
                onChanged: (String val) {
                  setState(() {
                    checklistModel.items[index].text = val;
                  });
                },
              ),
              trailing: IconButton(
                  icon: Icon(Icons.clear_rounded),
                  color: Colors.grey.withOpacity(0.9),
                  onPressed: () {
                    if (checklistModel.items.length == 1) {
                      setState(() {
                        checklistModel.items[index]._textEditingController.clear();
                      });
                    } else {
                      setState(() {
                        checklistModel.items.removeAt(index);
                      });
                      // }

                    }
                  }),
            ));
          }),
    );
  }
}

//class ChecklistItemModel {
//  bool isChecked;
//  String text;
//  ChecklistItemModel({this.text, this.isChecked});
//  TextEditingController _textEditingController = new TextEditingController();
//}
class ChecklistItemModel {
  bool isChecked;
  String text;
  TextEditingController _textEditingController = new TextEditingController();

  ChecklistItemModel({this.isChecked, this.text}) {
    _textEditingController.text = text;
  }

  ChecklistItemModel.fromJson(Map<String, dynamic> json) {
    isChecked = json['isChecked'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isChecked'] = this.isChecked;
    data['text'] = this.text;
    return data;
  }
}

class ChecklistModel {
  DateTime date = DateTime.now();
  List<ChecklistItemModel> items = [];
  ChecklistModel({this.date, this.items});
}
