import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notably/components/page_transition.dart';
import 'package:notably/screens/create.dart';
import 'package:notably/utils/theme.dart';
import 'package:notably/utils/toast.dart';
import 'package:notably/utils/utility.dart';
import 'package:notably/widgets/dialogs.dart';
import 'package:notably/widgets/drawer.dart';
import 'package:notably/widgets/listview.dart';
import 'package:notably/widgets/pop_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesView extends StatefulWidget {
  var user;
  var pageTitle;
  bool selector = false;
  List<String> allSnapshot;
  List<String> selectedNotes = <String>[];

  NotesView(this.user,
      {this.pageTitle, this.selector, this.selectedNotes, this.allSnapshot});

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  var pageTitle;
  final double appBarHeight = 66.0;
  var noteCount = 0;
  bool showHeaderText = false;
  bool showMoveUpArrow = false;
  ScrollController _scrollController;
  int sortType = 0;
  int userSortOrder = 0;
  SharedPreferences local;
  bool drawerState = false;
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  List<String> selectedNotes = <String>[];
  var userViewSetting = 1;

  getUserSettings() async {
    local = await SharedPreferences.getInstance();
    if (local.getInt('user-sort-settings') != null) {
      setState(() {
        sortType = local.getInt('user-sort-settings');
      });
    }
    if (local.getInt('user-sort-order') != null) {
      setState(() {
        userSortOrder = local.getInt('user-sort-order');
      });
    }
    if (local.getInt('user-view-settings') != null) {
      setState(() {
        userViewSetting = local.getInt('user-view-settings');
      });
    }
  }



  getStream() {

    return Firestore.instance
        .collection('notes')
        .where('userId', isEqualTo: widget.user)
        .orderBy((sortType == 0 ? 'title' : sortType == 1 ? 'timestamp' : 'updated'), descending: (userSortOrder == 1))
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserSettings();
    setState(() {
      this.pageTitle = widget.pageTitle;
      this.selectedNotes = widget.selectedNotes;
    });
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 300) {
          if (showMoveUpArrow != true) {
            setState(() {
              showMoveUpArrow = true;
            });
          }
        } else {
          setState(() {
            showMoveUpArrow = false;
          });
        }

        if (_isAppBarExpanded) {
          setState(() {
            showHeaderText = true;
          });
        } else {
          if (showHeaderText == true) {
            setState(() {
              showHeaderText = false;
            });
          }
        }
      });
  }

  bool get _isAppBarExpanded {
    return _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: () {
        if (widget.selector) {
          setState(() {
            widget.selector = false;
            widget.selectedNotes = <String>[];
          });
        }
        return;
      },
      child: Scaffold(
        backgroundColor: AppTheme.color1,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              showMoveUpArrow
                  ? FloatingActionButton(
                      onPressed: () {
                        _scrollController.animateTo(200.0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Icon(Icons.arrow_upward),
                    )
                  : Spacer(),
              widget.selector ? Container() : FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition.scaleRoute(
                            page: CreateNote(
                          widget.user,
                          "1",
                          noteTitle: '',
                          noteContent: '',
                        )));
                  },
                  backgroundColor: AppTheme.color1,
                  child: Icon(Icons.add))
            ],
          ),
        ),
        bottomNavigationBar: widget.selector
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: AppTheme.color1,
                onTap: (int value)async  {
                  if(value == 3){
                    Flash().show(context,2, 'Deleting', Colors.black54, 16, Colors.white, null);
                    var db= Firestore.instance;
                    var batch = db.batch();
                    widget.selectedNotes.map((value) {
                          widget.selectedNotes.remove(value);
                            batch.delete(Firestore.instance.collection('notes')
                                .document(value));

                    }).toList();

                    batch.commit().then((value) {
                      setState(() {
                        widget.selector = false;
                      });
                    });

                  }
                },
                items: [
                    BottomNavigationBarItem(
                        title: Text('Share'), icon: Icon(FeatherIcons.share2)),
                    BottomNavigationBarItem(
                        title: Text('Move'),
                        icon: Icon(FeatherIcons.arrowRight)),
                    BottomNavigationBarItem(
                        title: Text('Lock'), icon: Icon(FeatherIcons.lock)),
                    BottomNavigationBarItem(
                        title: Text('Delete'), icon: Icon(FeatherIcons.trash)),
                  ])
            : null,
        body: Builder(builder: (context) {
          return SliderMenuContainer(
            key: _key,
            appBarPadding: EdgeInsets.all(0),
            drawerIcon: Container(),
            sliderMenuOpenOffset: 250,
            appBarHeight: 0,
            sliderMenuWidget: AppDrawer(
              currentPage: 0,
              allNotesCount: 0,
              allRecycleBinCount: 0,
              allSharedCount: 0,
              onTap: (value) {
                print(value);
              },
            ),
            sliderMainWidget: Container(
              decoration: BoxDecoration(gradient: AppTheme.linearGradient),
              child: StreamBuilder(
                  stream: getStream(),
                  builder: (context, snapshot) {
                    noteCount =
                        snapshot.hasData ? snapshot.data.documents.length : 0;

                    return CustomScrollView(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverAppBar(
                          pinned: true,
                          automaticallyImplyLeading: false,
                          leading: showHeaderText
                              ? widget.selector
                                  ? showAllIconButtonForTopBar(context)
                                  : IconButton(
                                      onPressed: () {
                                        if (drawerState) {
                                          _key.currentState.closeDrawer();
                                        } else {
                                          _key.currentState.openDrawer();
                                        }
                                        setState(() {
                                          drawerState = !drawerState;
                                        });
                                      },
                                      icon: Icon(
                                        drawerState ? Icons.close : Icons.menu,
                                        color: Colors.white,
                                      ),
                                    )
                              : null,
                          actions: showHeaderText
                              ? widget.selector
                                  ? []
                                  : <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                      ),
                                      PopMenu(
                                        iconColor: Colors.white,
                                        color: Colors.transparent,
                                        items: [
                                          PopupMenuItem<String>(
                                              value: "1", child: Text('Edit')),
                                          PopupMenuItem<String>(
                                              value: "2", child: Text('Sort')),
                                          PopupMenuItem<String>(
                                              value: "3", child: Text('View')),
                                        ],
                                        onSelected: (value) {
                                          if (value == "1") {
                                            setState(() {
                                              widget.selector = true;
                                            });
                                          }

                                          if (value == "2") {
                                            Dialogs.show(
                                                context: context,
                                                type: DialogType.sort);
                                          }

                                          if (value == "3") {
                                            Dialogs.show(
                                                context: context,
                                                type: DialogType.view);
                                          }
                                        },
                                      ),
                                    ]
                              : null,
                          elevation: 0,
                          backgroundColor: showHeaderText
                              ? Color(0xff13547a)
                              : Colors.transparent,
                          expandedHeight: 250,
                          onStretchTrigger: () {
                            return;
                          },
                          flexibleSpace: FlexibleSpaceBar(
                            title: showHeaderText
                                ? Text((widget.selector
                                        ? "(" +
                                            widget.selectedNotes.length
                                                .toString() +
                                            (widget.selectedNotes.length > 1
                                                    ? " Notes"
                                                    : " Note")
                                                .toString() +
                                            ") "
                                        : "") +
                                    widget.pageTitle)
                                : null,
                            centerTitle: true,
                            background: Container(
                              padding:
                                  new EdgeInsets.only(top: statusBarHeight),
                              height: statusBarHeight + appBarHeight,
                              child: new Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: new Text(
                                              (widget.selector
                                                      ? "(" +
                                                          widget.selectedNotes
                                                              .length
                                                              .toString() +
                                                          (widget.selectedNotes
                                                                          .length >
                                                                      1
                                                                  ? " Notes"
                                                                  : " Note")
                                                              .toString() +
                                                          ") "
                                                      : "") +
                                                  widget.pageTitle,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 28.0)),
                                        ),
                                        Container(
                                          child: new Text(
                                              "${noteCount.toString()} Note" +
                                                  (noteCount > 1 ? "s" : ""),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 15.0)),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        lowerActionButtons(context)
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                              decoration: new BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        _addView(context, snapshot),
                      ],
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }

  Widget showAllIconButtonForTopBar(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          print(widget.selectedNotes.length);
          if (noteCount == widget.selectedNotes.length) {
            widget.selectedNotes = [];
          } else {
            widget.allSnapshot.map((value) {
              if (!widget.selectedNotes.contains(value)) {
                widget.selectedNotes.add(value);
              }
            }).toList();
          }
        });
      },
      icon: Icon(
        noteCount != widget.selectedNotes.length
            ? Icons.radio_button_unchecked
            : Icons.radio_button_checked,
        color: Colors.white,
        size: 25,
      ),
    );
  }

  Widget lowerActionButtons(BuildContext context) {
    if (widget.selector) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  print(widget.selectedNotes.length);
                  if (noteCount == widget.selectedNotes.length) {
                    widget.selectedNotes = [];
                  } else {
                    widget.allSnapshot.map((value) {
                      if (!widget.selectedNotes.contains(value)) {
                        widget.selectedNotes.add(value);
                      }
                    }).toList();
                  }
                });
              },
              icon: Icon(
                noteCount != widget.selectedNotes.length
                    ? Icons.radio_button_unchecked
                    : Icons.radio_button_checked,
                color: Colors.white,
                size: 25,
              ),
            ),
            Text(
              'All',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              if (drawerState) {
                _key.currentState.closeDrawer();
              } else {
                _key.currentState.openDrawer();
              }
              setState(() {
                drawerState = !drawerState;
              });
            },
            icon: Icon(
              drawerState ? Icons.close : Icons.menu,
              color: Colors.white,
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              PopMenu(
                iconColor: Colors.white,
                color: Colors.transparent,
                items: [
                  PopupMenuItem<String>(value: "1", child: Text('Edit')),
                  PopupMenuItem<String>(value: "2", child: Text('Sort')),
                  PopupMenuItem<String>(value: "3", child: Text('View')),
                ],
                onSelected: (value) {
                  if (value == "1") {
                    setState(() {
                      widget.selector = true;
                    });
                  }

                  if (value == "2") {
                    Dialogs.show(
                        context: context,
                        type: DialogType.sort,
                      sortValue: {'type' : sortType, 'order' : userSortOrder},
                      onTap: (data) {

                          saveUserData(data);
                          return;
                      },
                      onChanged: (data) {

                      }
                    );
                  }

                  if (value == "3") {
                    Dialogs.show(
                      onTap: (data) {

                        saveUserData(data);
                        return;
                      },
                        context: context,
                        type: DialogType.view,
                        viewtype: userViewSetting,
                    );
                  }
                },
              )
            ],
          ),
        ],
      );
    }
  }

  saveUserData(data)async {
    data.forEach((k,v){
      if(k.toString() == 'type'){
        setState(() {
          sortType = v;
          local.setInt('user-sort-settings', v);
        });
      }

      if(k.toString() == 'order'){
        setState(() {
          userSortOrder= v;
          local.setInt('user-sort-order', v);
        });
      }
      if(k.toString() == 'view'){
        setState(() {
          userViewSetting= v;
          local.setInt('user-view-settings', v);
        });
      }
    });
  }

  _addView(context, snapshot) {
    return ListViewBuilder(
      context: context,
      snapshot: snapshot,
      selectedNotes: widget.selectedNotes,
      selector: widget.selector,
      allSnapshot: widget.allSnapshot,
      userViewSetting: this.userViewSetting,
      onLongPress: (data, selector) {
        if (selector) {
        } else {
          setState(() {
            widget.selector = true;
            widget.selectedNotes.add(data.documentID);
          });
        }
      },
      onTap: (data, selector) {
        if (selector) {

          if (widget.selectedNotes.contains(data.documentID)) {
            setState(() {
              widget.selectedNotes.remove(data.documentID);
            });
          } else {
            setState(() {
              widget.selectedNotes.add(data.documentID);
            });
          }
        } else {
          Navigator.push(
              context,
              PageTransition.scaleRoute(
                  page: CreateNote(
                widget.user,
                data.documentID,
                noteTitle: data['title'],
                noteContent: data['content'],
                created: data['timestamp'],
                updated: data['updated'],
              )));
        }
      },
    );
  }
}
