
import 'package:flutter/material.dart';
import 'package:notably/utils/theme.dart';

class Dialogs  {


  static sort({@required BuildContext context, @required DialogType type}) {

    if(type == DialogType.sort){
      //return a sort widget
      return showDialog(context: context,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Sort by',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.radio_button_unchecked),
                  ),
                  title: Text('Title'),
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.radio_button_unchecked),
                  ),
                  title: Text('Date Created'),
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.radio_button_unchecked),
                  ),
                  title: Text('Date Modified'),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Order'),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        height: 1,
                      )
                    )
                  ],
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.radio_button_unchecked),
                  ),
                  title: Text('Ascending'),
                ),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.radio_button_unchecked),
                  ),
                  title: Text('Descending'),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: <Widget>[
                    Expanded( 
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top:10, left: 10, right: 10),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.color1),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top:10, left: 10, right: 10),
                          child: Text(
                              'Done',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.color1),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      );
    } else if( type == DialogType.view) {
      //return a view widget
      return showDialog(context: context,
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('View by',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.radio_button_unchecked),
                    ),
                    title: Text('Grid'),
                  ),

                  ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.radio_button_unchecked),
                    ),
                    title: Text('List'),
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.radio_button_unchecked),
                    ),
                    title: Text('Simple List'),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top:10, left: 10, right: 10),
                            child: Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppTheme.color1),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top:10, left: 10, right: 10),
                            child: Text(
                              'Done',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppTheme.color1),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
      );
    }
  }

  static view({@required context, @required type}) {
    BuildContext context;
    DialogType type;
  }


}

enum DialogType {
  sort,
  view,
}
