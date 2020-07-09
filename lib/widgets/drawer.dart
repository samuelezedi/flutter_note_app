import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:notably/utils/theme.dart';

typedef void DrawerCallBack(int value);

class AppDrawer extends StatelessWidget {
  final int allNotesCount;
  final int allSharedCount;
  final int allRecycleBinCount;
  final DrawerCallBack onTap;
  final Widget builder;

  AppDrawer(
      {this.allNotesCount,
      this.allSharedCount,
      this.allRecycleBinCount,
        this.builder,
      this.onTap})
      : assert(allNotesCount != null),
        assert(allSharedCount != null),
        assert(allRecycleBinCount != null),
        assert(onTap != null);


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: Drawer(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.linearGradient2,
          ),
          padding: EdgeInsets.only(right: 10, top: 25, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: AppTheme.color1,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  onTap: (){
                    this.onTap(1);
                  },
                  leading: Icon(FeatherIcons.book, color: Colors.grey[600]),
                  title: Text('All notes',
                      style: TextStyle(color: AppTheme.color1)),
                ),
                ListTile(
                  onTap: (){
                    this.onTap(1);
                  },
                  leading: Icon(FeatherIcons.users, color: Colors.grey[600]),
                  title: Text(
                    'Shared Notes',
                    style: TextStyle(color: AppTheme.color1),
                  ),
                ),
                ListTile(
                  onTap: (){
                    this.onTap(2);
                  },
                  leading:
                      Icon(FeatherIcons.refreshCcw, color: Colors.grey[600]),
                  title: Text('Recycle bin',
                      style: TextStyle(color: AppTheme.color1)),
                ),

                Divider(
                  height: 1,
                  color: AppTheme.color2,
                ),
                Expanded(
                  child: Container()
                ),
                Divider(
                  height: 1,
                  color: AppTheme.color2,
                ),
                ListTile(
                  onTap: (){
                    this.onTap(2);
                  },
                  leading:
                  Icon(FeatherIcons.info, color: Colors.grey[600]),
                  title: Text('About',
                      style: TextStyle(color: AppTheme.color1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
