import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterAcmFall/screens/grocChecklistScreen.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';




class ChecklistCreationScreen extends StatefulWidget {
  @override
  _ChecklistCreationScreen createState() => _ChecklistCreationScreen();
}

class _ChecklistCreationScreen extends State<ChecklistCreationScreen> {

ChecklistModel checklistModel= ChecklistModel(date: DateTime.now(), items: []);

  initState(){
    checklistModel.items.add(ChecklistItemModel(text:"",isChecked:false));
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


        leading: Builder(
          builder: (BuildContext context) {
         return

          FlatButton(

            textColor: Color.fromRGBO(0,108,255,1),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel",
              style: new TextStyle(fontSize: 18, fontFamily:'SFProText', fontWeight: FontWeight.w400),
            ),

          );}),
          actions: <Widget>[
            FlatButton(
              textColor: Color.fromRGBO(0, 108, 255, 1),

             onPressed: () {


              Navigator.pop(context);
              },
              child: Text("Done",
                style: new TextStyle(fontSize: 18, fontFamily:'SFProText',fontWeight: FontWeight.w700),

              ),
          )
        ], automaticallyImplyLeading: false,
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
                    maxTime: DateTime(2100, 6, 7),
                    onConfirm: (date) {
                      setState(() {
                        checklistModel.date = date;

                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);

              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[new Icon(Icons.calendar_today_outlined, color:Color.fromRGBO(135,135,135,1))],
              ),
            ),
            Text(DateFormat('MM/dd/yyyy – kk:mm').format(checklistModel.date)
            )


          ],
        )
      ],

        body: ListView.builder(
          itemCount: checklistModel.items.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(

                child: CheckboxListTile(
                        title: TextField(
                          style: TextStyle(fontFamily: 'SFProText', fontSize: 18, color: Color.fromRGBO(37,42,49,1)),

                          onSubmitted: (String input){
                            setState(() {
                              if(input.isNotEmpty) {
                                checklistModel.items.add(ChecklistItemModel(
                                    text: "", isChecked: false));
                              }});
                          },
                            controller: checklistModel.items[index]._textEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            hintText: "What do you want to do?",
                            hintStyle: TextStyle(fontFamily:'SFProText', fontSize: 18, color: Color.fromRGBO(135,135,135,1)),
                            )
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            value: checklistModel.items[index].isChecked,
                            secondary: IconButton(
                              icon: Icon(Icons.clear_rounded),
                              color: Colors.grey.withOpacity(0.9),
                              onPressed: () {
                                if (index == 0) {
                                  setState(() {
                                    checklistModel.items[index]._textEditingController.clear();
                                  });
                                }
                                else {
                                  setState(() {
                                    checklistModel.items.removeAt(index);
                                  });
                                  // }

                                }
                              }),
                        onChanged: (bool value) {
                          setState(() {
                            checklistModel.items[index].isChecked = value;
                          });
                        },
                        activeColor: Colors.blue,
                        checkColor: Colors.white),




            );
          }),
    );
  }
}

class ChecklistItemModel{
  bool isChecked;
  String text;
  ChecklistItemModel({this.text, this.isChecked});
  TextEditingController _textEditingController = new TextEditingController();

}

class ChecklistModel{
  DateTime date = DateTime.now();
  List<ChecklistItemModel> items = [];
  ChecklistModel({this.date, this.items});

}



