import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainView()
    );
  }
}

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final double appBarHeight = 66.0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('All Notes'),
            expandedHeight: 250,
            onStretchTrigger: (){

            },
            flexibleSpace: FlexibleSpaceBar(
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
                              Container(child: new Text(
                                  "Balance",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 28.0
                                  )
                              ),),
                              Container(child: new Text(
                                  "\u002420,914.33",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 36.0
                                  )
                              ),),
                            ],),),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(child: Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: new Text(
                                    "\u002B24.93\u0025",
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Poppins',
                                        fontSize: 20.0
                                    )
                                ),
                              ),),

                              Container(child: Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Icon(
                                  Icons.arrow_upward, color: Colors.green,),
                              ),),

                            ],),
                        ),


                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0,left:8.0),
                                child: new Text(
                                    "Currency",
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0
                                    )
                                ),
                              ),),

                              Container(child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0,right:8.0),
                                child: Container(
                                    child: Row(children: <Widget>[
                                      Container(child: Icon(
                                        Icons.calendar_today, color: Colors.white,
                                      ),),
                                      SizedBox(width: 10,),
                                      Container(child: Text(
                                        'Janaury 2019', style: const TextStyle(
                                          color: Colors.white70,
                                          fontFamily: 'Poppins',
                                          fontSize: 16.0
                                      ),),),
                                    ],)

                                ),
                              ),),


                            ],),
                        ),
                      ],)
                ),
                decoration: new BoxDecoration(
                  color: Color(0xff013db7),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

