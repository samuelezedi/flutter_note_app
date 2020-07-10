import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notably/screens/all_notes.dart';
import 'package:notably/screens/selected.dart';
import 'package:notably/utils/theme.dart';
import 'package:notably/widgets/drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Notablee',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Rubik',
          primarySwatch: MaterialColor(AppTheme.colorCode1, AppTheme.colorCodes),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AppBody());
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AllNotesView('sdf'
    );
  }
}


