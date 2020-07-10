
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black54,),
        ),
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: 13, bottom: 13, right: 30),
              child: Text('Save',style: TextStyle(color: Colors.black54,fontSize: 20),),
            ),
          ),

        ],
      ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(

                ),
              ),
              TextFormField(

              ),
            ],
          ),
        )
    );
  }
}
