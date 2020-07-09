
import 'package:flutter/material.dart';

typedef void PopMenuCallBack(String value);

class PopMenu extends StatelessWidget {

  final Color iconColor;
  final Color color;
  final List<PopupMenuEntry<String>> items;
  final PopMenuCallBack onSelected;

  PopMenu({
    this.iconColor = Colors.white,
    this.color,
    @required this.items,
    this.onSelected
  }) : assert(items != null);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color:this.color,
            borderRadius: BorderRadius.circular(50)
        ),
        child: Icon(Icons.more_vert,color: iconColor,),
      ),
      itemBuilder: (BuildContext context) => this.items,
        onSelected: (value) {
          return value;
        },
    );
  }
}
