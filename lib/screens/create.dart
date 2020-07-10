
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
          onPressed: (){
            Navigator.pop(context);
          },
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
                onChanged: (input){

                },
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                ),
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                ),
              ),
              Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Notes:',style: TextStyle(fontSize: 17,
                    ),),
                  ),
                  TextFormField(
                    onChanged: (input){
                      setState(() {

                      });
                    },
                    minLines: 1,
                    maxLines: 300,
                    style: TextStyle(
                        fontSize: 17
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter notes',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
