
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';


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
              color: Color(0xff13547a),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
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
