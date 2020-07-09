
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
              gradient: AppTheme.linearGradient2,
          ),
          padding: EdgeInsets.only(right: 10,top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)
              )
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {

                      },
                      icon: Icon(Icons.settings,color: AppTheme.color1,),
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
      ),
    );
  }
}
