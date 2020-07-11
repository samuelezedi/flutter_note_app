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
  final int currentPage;

  AppDrawer(
      {this.allNotesCount,
      this.allSharedCount,
      this.allRecycleBinCount,
      this.builder,
      @required this.currentPage,
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
        child: GestureDetector(

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
                      onTap: () {
                        this.onTap(0);
                      },
                      leading: Icon(FeatherIcons.book, color: Colors.grey[600]),
                      title: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: this.currentPage == 0 ? Colors.grey[200] : Colors.transparent
                        ),
                        child: Text('All notes',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.color1)),
                      ),
                    ),


                   ListTile(
                      onTap: () {
                        this.onTap(1);
                      },
                      leading: Icon(FeatherIcons.users, color: Colors.grey[600]),
                      title: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: this.currentPage == 1 ? Colors.grey[200] : Colors.transparent
                        ),
                        child: Text(
                          'Shared Notes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.color1,),
                        ),
                      ),
                    ),

                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: this.currentPage == 2 ? Colors.grey[400] : Colors.transparent
                    ),
                    child: ListTile(
                      onTap: () {
                        this.onTap(2);
                      },
                      leading:
                          Icon(FeatherIcons.refreshCcw, color: Colors.grey[600]),
                      title: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: this.currentPage == 1 ? Colors.grey[200] : Colors.transparent
                        ),
                        child: Text('Recycle bin',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.color1)),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: AppTheme.color2,
                  ),
                  ListTile(
                    onTap: () {
                      this.onTap(2);
                    },
                    title:
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: this.currentPage == 3 ? Colors.grey[200] : Colors.transparent
                        ),
                        child: Text('Manage Categories', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.color1))),
                  ),
                  Expanded(child: Container()),
                  Divider(
                    height: 1,
                    color: AppTheme.color2,
                  ),
                  ListTile(
                    onTap: () {
                      this.onTap(2);
                    },
                    leading: Icon(FeatherIcons.info, color: Colors.grey[600]),
                    title:
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: this.currentPage == 4 ? Colors.grey[200] : Colors.transparent
                            ),
                            child: Text('About', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.color1))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
