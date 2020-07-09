import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notably/widgets/drawer.dart';

class AllNotesView extends StatefulWidget {
  @override
  _AllNotesViewState createState() => _AllNotesViewState();
}

class _AllNotesViewState extends State<AllNotesView> {
  final double appBarHeight = 66.0;

  bool showHeaderText = false;
  bool showMoveUpArrow = false;
  ScrollController _scrollController;

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
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Color(0xff013db7),
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
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: Builder(
          builder: (context) {
            return CustomScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  leading: showHeaderText
                      ? IconButton(
                    onPressed: (){
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
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
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    )
                  ]
                      : null,
                  elevation: 0,
                  backgroundColor: Color(0xff013db7),
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                                              fontFamily: 'Poppins',
                                              fontSize: 28.0)),
                                    ),
                                    Container(
                                      child: new Text("note count",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15.0)),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: (){
                                            Scaffold.of(context).openDrawer();
                                          },
                                          icon: Icon(
                                            Icons.menu,
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
                                            IconButton(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: Colors.white,
                                              ),
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
                        color: Color(0xff013db7),
                      ),
                    ),
                  ),
                ),
                SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 4,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) => new Container(
                      color: Colors.green,
                      child: new Center(
                        child: new CircleAvatar(
                          backgroundColor: Colors.white,
                          child: new Text('$index'),
                        ),
                      )),
                  staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 2 : 1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ],
            );
          }
      ),
    );
  }
}
