import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Sele extends StatelessWidget {

  GlobalKey<SliderMenuContainerState> _key =
  new GlobalKey<SliderMenuContainerState>();
  String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderMenuContainer(

          key: _key,
          drawerIcon: Container(),
          sliderMenuOpenOffset: 250,
          appBarHeight: 60,

          sliderMenuWidget: Container(
            child: Column(
              children: <Widget>[
                Text('dsf'),
                Text('dsf')
              ],
            ),
          ),
          sliderMainWidget: Column(
            children: <Widget>[
              Text('ere')
            ],
          )
      ),

    );
  }
}