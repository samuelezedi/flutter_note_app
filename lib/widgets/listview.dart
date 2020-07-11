import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notably/components/page_transition.dart';
import 'package:notably/screens/create.dart';
import 'package:notably/utils/theme.dart';
import 'package:notably/utils/utility.dart';

typedef dynamic LVBCallBack(data, bool selector);

class ListViewBuilder extends StatelessWidget {
  final BuildContext context;
  final snapshot;
  final userViewSetting;
  final List<String> allSnapshot;
  final bool selector;
  final LVBCallBack onLongPress;
  final LVBCallBack onTap;
  final List<String> selectedNotes;

  ListViewBuilder(
      {this.context,
      this.snapshot,
      this.userViewSetting,
      this.allSnapshot,
      this.onLongPress,
      this.onTap,
      this.selector,
      this.selectedNotes});

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      if (snapshot.data.documents.length > 0) {
        if (userViewSetting == 0) {
          return SliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              var data = snapshot.data.documents[index];
              this.allSnapshot.add(data.documentID);
              return GestureDetector(
                onTap: () {
                  return this.onTap(data, this.selector);
                },
                onLongPress: () {
                  //TODO should take you to selected page
                  return this.onLongPress(data, this.selector);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              this.selector
                                  ? SizedBox(
                                      height: 25,
                                    )
                                  : Container(),
                              Text(
                                data['title'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                  child: Text(
                                data['content'],
                                overflow: TextOverflow.fade,
                              ))
                            ],
                          ),
                        ),
                        Visibility(
                            visible: this.selector,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: AppTheme.color1, width: 2)),
                                child:
                                    this.selectedNotes.contains(data.documentID)
                                        ? CircleAvatar(
                                            backgroundColor: AppTheme.color1,
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                          ),
                              ),
                            ))
                      ],
                    )),
              );
            },
            staggeredTileBuilder: (int index) {
              var data = snapshot.data.documents[index];
              var l = data['content'].toString().length;
              var h = 1.0;
              if (l < 50) {
                h = 1.5;
              } else if (l > 50 && l < 200) {
                h = 2.0;
              } else if (l > 200 && l < 500) {
                h = 2.5;
              } else if (l > 500) {
                h = 3;
              }

              return StaggeredTile.count(2, h);
            },
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          );
        } else if (userViewSetting >= 1) {
          var widgets = <Widget>[];
          for (var index = 0; index < snapshot.data.documents.length; index++) {
            var data = snapshot.data.documents[index];
            this.allSnapshot.add(data.documentID);
            var wid = GestureDetector(
                onTap: () {
                  return this.onTap(data, this.selector);
                },
                onLongPress: () {
                  return this.onLongPress(data, this.selector);
                },
                child: Container(
                    height: userViewSetting == 2 ? 80 : 130,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                this.selector
                                    ? SizedBox(
                                        height: 22,
                                      )
                                    : Container(),
                                Text(
                                  data['title'],
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                userViewSetting == 1 ? SizedBox(
                                  height: 15,
                                ):Container(),
                                userViewSetting == 1 ? Expanded(
                                    child: Text(
                                  data['content'],
                                  overflow: TextOverflow.fade,
                                )) : Container(),
                                userViewSetting == 1 ? SizedBox(
                                  height: 15,
                                ): Container(),
                                Text(
                                  Utility.getHumanTime(data['timestamp']),
                                  style: TextStyle(fontSize: 11),
                                )
                              ]),
                        ),
                        Visibility(
                            visible: this.selector,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: AppTheme.color1, width: 2)),
                                child:
                                    this.selectedNotes.contains(data.documentID)
                                        ? CircleAvatar(
                                            backgroundColor: AppTheme.color1,
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                          ),
                              ),
                            ))
                      ],
                    )));
            widgets.add(wid);
          }
          return SliverList(
            delegate: SliverChildListDelegate(widgets),
          );
        }
      } else {
        return SliverToBoxAdapter(
          child: Container(
            child: Center(
                child: Text(
              'You have no note yet',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
        );
      }
    } else {
      return SliverToBoxAdapter(
          child: Column(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ));
    }
  }
}
