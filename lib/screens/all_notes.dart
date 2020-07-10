import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notably/components/page_transition.dart';
import 'package:notably/screens/create.dart';
import 'package:notably/utils/theme.dart';
import 'package:notably/widgets/drawer.dart';
import 'package:notably/widgets/pop_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllNotesView extends StatefulWidget {
  var user;

  AllNotesView(this.user);

  @override
  _AllNotesViewState createState() => _AllNotesViewState();
}

class _AllNotesViewState extends State<AllNotesView> {
  final double appBarHeight = 66.0;
  bool showHeaderText = false;
  bool showMoveUpArrow = false;
  ScrollController _scrollController;
  int sortType = 0;
  SharedPreferences local;
  bool drawerState = false;
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();

  checkSortChoice() async {
    local = await SharedPreferences.getInstance();
    if (local.getInt('sort-pref') == null) {
    } else {
      setState(() {
        sortType = local.getInt('sort-pref');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    return Scaffold(
      backgroundColor: Color(0xff13547A),
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
            FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context, PageTransition.scaleRoute(page: CreateNote(widget.user, "1",noteTitle: '',noteContent: '',)));
                },
                backgroundColor: AppTheme.color1,
                child: Icon(Icons.add))
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return SliderMenuContainer(
          key: _key,
          appBarPadding: EdgeInsets.all(0),
          drawerIcon: Container(),
          sliderMenuOpenOffset: 250,
          appBarHeight: 0,
          sliderMenuWidget: AppDrawer(
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
                stream: Firestore.instance
                    .collection('notes')
                    .where('userId', isEqualTo: widget.user)
                    .orderBy('favourite', descending: true)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return CustomScrollView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        automaticallyImplyLeading: false,
                        leading: showHeaderText
                            ? IconButton(
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
                            ? <Widget>[
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
                                    print(value);
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
                          title: showHeaderText ? Text('All Notes') : null,
                          centerTitle: true,
                          background: Container(
                            padding: new EdgeInsets.only(top: statusBarHeight),
                            height: statusBarHeight + appBarHeight,
                            child: new Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: new Text("All Notes",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 28.0)),
                                      ),
                                      Container(
                                        child: new Text("note count",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 15.0)),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              drawerState
                                                  ? Icons.close
                                                  : Icons.menu,
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
                                                  PopupMenuItem<String>(
                                                      value: "1",
                                                      child: Text('Edit')),
                                                  PopupMenuItem<String>(
                                                      value: "2",
                                                      child: Text('Sort')),
                                                  PopupMenuItem<String>(
                                                      value: "3",
                                                      child: Text('View')),
                                                ],
                                                onSelected: (value) {
                                                  print(value);
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      )
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
    );
  }

  _addView(context, snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data.documents.length > 0) {
        if (sortType == 0) {
          return SliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) => new Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: new Center(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text('$index'),
                  ),
                )),
            staggeredTileBuilder: (int index) {
              return StaggeredTile.count(2, index.isEven ? 2 : 1);
            },
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10,
          );
        } else {
          return SliverList(
            delegate: SliverChildListDelegate([]),
          );
        }
      } else {
        return SliverToBoxAdapter(
          child: Container(
            child: Center(child: Text('You have no note yet',style: TextStyle(color: Colors.white,fontSize: 20),)),
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
