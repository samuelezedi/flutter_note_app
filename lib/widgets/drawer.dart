
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:notably/utils/theme.dart';


class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent
      ),
      child: Drawer(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              gradient: AppTheme.linearGradient,

          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.settings),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                leading: Icon(FeatherIcons.book, color: Colors.white,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
