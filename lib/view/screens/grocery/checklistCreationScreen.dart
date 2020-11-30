import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterAcmFall/view/screens/grocery/grocChecklistScreen.dart';
import 'package:flutterAcmFall/view/screens/grocery/my_grocery_lists.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

typedef void ListCallback(ChecklistModel cm);

class ChecklistCreationScreen extends StatefulWidget {
  @override
  _ChecklistCreationScreen createState() =>
      _ChecklistCreationScreen(callback: callback, checklistModel: checklistModel, createNew: createNew);

  final ListCallback callback;
  final ChecklistModel checklistModel;
  final bool createNew;
  ChecklistCreationScreen({this.callback, this.checklistModel, this.createNew});
}

class _ChecklistCreationScreen extends State<ChecklistCreationScreen> {
  final ListCallback callback;
  bool createNew;

  _ChecklistCreationScreen({this.callback, this.checklistModel,this.createNew});

  ChecklistModel checklistModel = ChecklistModel(date: DateTime.now(), items: []);

  initState() {
    if(createNew==true){
      checklistModel.items.add(ChecklistItemModel(text: "", isChecked: false));

    }

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
              style: new TextStyle(
                  fontSize: 18,
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w400),
            ),
          );
        }),
        actions: <Widget>[
          FlatButton(
            textColor: Color.fromRGBO(0, 108, 255, 1),
            onPressed: () {
              callback(checklistModel);
              Navigator.pop(context);
            },
            child: Text(
              "Done",
              style: new TextStyle(
                  fontSize: 18,
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w700),
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
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2100, 6, 7), onConfirm: (date) {
                  setState(() {
                    checklistModel.date = date;
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Icon(Icons.calendar_today_outlined,
                      color: Color.fromRGBO(135, 135, 135, 1))
                ],
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
                    style: TextStyle(
                        fontFamily: 'SFProText',
                        fontSize: 18,
                        color: Color.fromRGBO(37, 42, 49, 1)),
                    onSubmitted: (String input) {
                      if (input.isNotEmpty) {
                        checklistModel.items.add(
                            ChecklistItemModel(text: "", isChecked: false));
                      }
                    },
                    controller:
                        checklistModel.items[index]._textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What do you want to do?",
                      hintStyle: TextStyle(
                          fontFamily: 'SFProText',
                          fontSize: 18,
                          color: Color.fromRGBO(135, 135, 135, 1)),
                    ),
                    onChanged: (String val) {
                      checklistModel.items[index].text = val;
                    },
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.clear_rounded),
                      color: Colors.grey.withOpacity(0.9),
                      onPressed: () {
                        if (index == 0) {
                          setState(() {
                            checklistModel.items[index]._textEditingController
                                .clear();
                          });
                        } else {
                          setState(() {
                            checklistModel.items.removeAt(index);
                          });
                          // }

                        }
                      }),

              ) );
          }),
    );
  }
}

class ChecklistItemModel {
  bool isChecked;
  String text;
  ChecklistItemModel({this.text, this.isChecked});
  TextEditingController _textEditingController = new TextEditingController();
}

class ChecklistModel {
  DateTime date = DateTime.now();
  List<ChecklistItemModel> items = [];
  ChecklistModel({this.date, this.items});
}
