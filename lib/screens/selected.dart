import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notably/screens/all_notes.dart';

class Selected extends StatelessWidget {
  var user;
  var allSnapshot;
  List<String> selectedNotes;
  Selected({this.user,this.allSnapshot, this.selectedNotes});
  @override
  Widget build(BuildContext context) {
    return NotesView('sdf', pageTitle: 'Selected',selector: true, selectedNotes: selectedNotes,allSnapshot: allSnapshot,);
  }
}
