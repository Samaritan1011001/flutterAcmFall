import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterAcmFall/screens/grocChecklistScreen.dart';

void main(){
  runApp(Buttons());
  runApp(ChecklistCreationScreen());
}

class Buttons extends StatelessWidget{

  final ChecklistScreen checklistscreen;
  Buttons(
      {
        Key key,
        this.checklistscreen,
      }) : super(key:key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: <Widget> [
          FlatButton(
             textColor: Color.fromRGBO(0,108,255,1),
              onPressed: (){Navigator.pop(context);
             },

           child: Text("Cancel"),
           ),
         FlatButton(
            textColor: Color.fromRGBO(0,108,255,1),
            onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder:(context)=>checklistscreen));

            },
           child: Text("Done"),
         )
    ],

    ),
        persistentFooterButtons: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget> [
              FlatButton(
                onPressed:(){},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Icon(Icons.calendar_today_outlined)

                  ],
                ),
              ),
              FlatButton(
                onPressed: (){},
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Icon(Icons.alarm),
                  ],
                ),
              ),
            ],
          ) 

      ],
    );
  }

}




class ChecklistCreationScreen extends StatefulWidget{




  @override
  _ChecklistCreationScreen createState() => _ChecklistCreationScreen();

}

class _ChecklistCreationScreen extends State<ChecklistCreationScreen>{
  List<String>items = List();
  final TextEditingController _textFieldController= new TextEditingController();

  bool isChecked = false;
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.delete), onPressed: (){
              setState(() {
                items.removeLast();
              });
            })
          ]),




      body: new ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
              child: new Container(
                  padding: new EdgeInsets.all(16.0),
                  child: new Column(
                    children: <Widget>[
                      new CheckboxListTile(
                          title: Text("What do you want to do?"),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isChecked,
                          secondary: IconButton(
                           icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: (){
                               setState(() {
                                items.removeAt(index);
                           });
                          }),

                          onChanged: (bool value) {
                            setState(() {
                              isChecked = value;
                            });
                          },

                          activeColor: Colors.blue,
                          checkColor: Colors.white

                      ),

                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: (){
                            showDialog(
                              context: context,
                                builder: (context) {
                                    return AlertDialog(
                                      title: Text('TextField in Dialog'),
                                       content: TextField(
                                       controller: _textFieldController,
                                         decoration: InputDecoration(
                                          hintText: "${items[index]}"),
                                           ),
                                     actions: <Widget>[
                                       new FlatButton(
                                           child: new Text('Done'),
                                          onPressed: () {
                                            setState(() {
                                              items[index] =_textFieldController.text;
                                              _textFieldController.clear();});
                                            Navigator.of(context).pop();
                                            })]);

              );]),
                  ));
        }
              ),);

    }
  }

