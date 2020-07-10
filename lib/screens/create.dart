
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:notably/models/notes.dart';
import 'package:notably/utils/toast.dart';

class CreateNote extends StatefulWidget {
  String noteTitle = '';
  String noteContent = '';
  String user;
  String type;
  CreateNote(this.user, this.type, {this.noteTitle, this.noteContent});
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {

  String noteTitle;
  String noteContent;
  String user;
  String type;

  @override
  void initState() {
    super.initState();
    setState(() {
      noteContent = widget.noteContent;
      noteTitle = widget.noteTitle;
      user = widget.user;
      type = widget.type;
    });
  }

  saveNote() {
    if(this.type == "1"){
      //means new note
      Notes notes = Notes(
          title: noteTitle,
          content: noteContent,
          timestamp: Timestamp.now(),
          updated: Timestamp.now(),
          userId: this.user
      );
      Firestore.instance.collection('notes')
          .add(notes.toMap()).then((value) {
        Flash().show(context, 2, 'Saved', Colors.black54, 15, null,null);
      });
    } else {

      Notes notes = Notes(
        title: noteTitle,
        content: noteContent,
        updated: Timestamp.now(),
      );
      //means old note
      Firestore.instance.collection('notes')
          .document(this.type)
          .updateData(
          notes.toMap()
      ).then((value) {
        Flash().show(context, 2, 'Saved', Colors.black54, 15, null,null);
      });
    }
  }

  autoSaveNote() {
    if(this.type == "1"){
      //means new note
      Notes notes = Notes(
        title: noteTitle,
        content: noteContent,
        timestamp: Timestamp.now(),
        updated: Timestamp.now(),
        userId: this.user
      );
      Firestore.instance.collection('notes')
      .add(notes.toMap()).then((value) {
        Flash().show(context, 2, 'Saved', Colors.black54, 15, null,null);
      });
    } else {

      Notes notes = Notes(
        title: noteTitle,
        content: noteContent,
        updated: Timestamp.now(),
      );
      //means old note
      Firestore.instance.collection('notes')
      .document(this.type)
          .updateData(
          notes.toMap()
      ).then((value) {
        Flash().show(context, 2, 'Saved', Colors.black54, 15, null,null);
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            autoSaveNote();
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
                  setState(() {
                    noteTitle = input;
                  });
                },
                initialValue: noteTitle,
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
                        noteContent = input;
                      });
                    },
                    initialValue: noteContent,
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
