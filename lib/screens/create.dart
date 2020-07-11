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
  Timestamp created;
  Timestamp updated;
  CreateNote(this.user, this.type,
      {this.noteTitle, this.noteContent, this.created, this.updated});
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  String prevNoteTitle;
  String prevNoteContent;
  String noteTitle;
  String noteContent;
  String user;
  String type;
  BuildContext mContext;
  bool notSave = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      noteContent = widget.noteContent;
      noteTitle = widget.noteTitle;
      prevNoteContent = widget.noteContent;
      prevNoteTitle = widget.noteTitle;
      user = widget.user;
      type = widget.type;
    });
  }

  saveNote() {
    if (notSave) {
      if (prevNoteContent != noteContent || prevNoteTitle != noteTitle) {
        setState(() {
          notSave = false;
        });
        if (this.type == "1") {
          //means new note
          Notes notes = Notes(
              title: noteTitle,
              content: noteContent,
              timestamp: Timestamp.now(),
              updated: Timestamp.now(),
              userId: this.user);
          Firestore.instance
              .collection('notes')
              .add(notes.toMap())
              .then((value) {
            setState(() {
              notSave = false;
            });
            Flash().show(context, 2, 'Saved', Colors.black54, 15, null, null);
          });
        } else {
          Notes notes = Notes(
              title: noteTitle,
              content: noteContent,
              updated: Timestamp.now(),
              timestamp: widget.created,
              userId: widget.user);
          //means old note
          Firestore.instance
              .collection('notes')
              .document(this.type)
              .updateData(notes.toMap())
              .then((value) {

            Flash().show(context, 2, 'Saved', Colors.black54, 15, null, null);
          });
        }
      } else {
        Flash().show(mContext, 1, 'You have nothing to save', Colors.red, 15,
            Colors.white, 2);
      }
    }
  }

  autoSaveNote() {
    if (notSave) {
      if (prevNoteContent != noteContent || prevNoteTitle != noteTitle) {
        if (this.type == "1") {
          //means new note
          Notes notes = Notes(
              title: noteTitle,
              content: noteContent,
              timestamp: Timestamp.now(),
              updated: Timestamp.now(),
              userId: this.user);
          Firestore.instance
              .collection('notes')
              .add(notes.toMap())
              .then((value) {
            Flash().show(context, 2, 'Saved', Colors.black54, 15, null, null);
          });
        } else {
          Notes notes = Notes(
              title: noteTitle,
              content: noteContent,
              updated: Timestamp.now(),
              timestamp: widget.created,
              userId: widget.user);
          //means old note
          Firestore.instance
              .collection('notes')
              .document(this.type)
              .updateData(notes.toMap())
              .then((value) {
            Flash().show(context, 2, 'Saved', Colors.black54, 15, null, null);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              autoSaveNote();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                saveNote();
              },
              child: Padding(
                padding: EdgeInsets.only(top: 13, bottom: 13, right: 30),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black54, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          mContext = context;
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (input) {
                            setState(() {
                              noteTitle = input;
                              notSave = true;
                            });
                          },
                          initialValue: noteTitle,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintText: 'Enter Title',
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]
                    )
                  ),
                  Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Notes:',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      TextFormField(
                        onChanged: (input) {
                          setState(() {
                            noteContent = input;
                            notSave = true;
                          });
                        },
                        initialValue: noteContent,
                        minLines: 1,
                        maxLines: 300,
                        style: TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                          hintText: 'Enter notes',
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
