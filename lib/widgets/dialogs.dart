
import 'package:flutter/material.dart';
import 'package:notably/utils/theme.dart';

typedef Map DialogsCallBack(data);

class Dialogs  {

  static show({@required BuildContext context, @required viewtype, @required DialogType type, @required DialogsCallBack onTap, @required DialogsCallBack onChanged, Map sortValue}) {

    Map selectedSort = Map();



    if(type == DialogType.sort){
      //return a sort widget
      return showDialog(context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Sort by', style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                          ListTile(
                            onTap: () {
                              setState(()
                              {
                                selectedSort['type'] = 0;
                                sortValue['type'] = 0;
                              });
                            },
                            leading: IconButton(
                              icon: Icon(sortValue['type'] == 0 ? Icons
                                  .radio_button_checked : Icons
                                  .radio_button_unchecked),
                            ),
                            title: Text('Title'),
                          ),
                          ListTile(
                            onTap: () {
                              setState((){
                                selectedSort['type'] = 1;
                                sortValue['type'] = 1;
                              });
                            },
                            leading: IconButton(
                              icon: Icon(sortValue['type'] == 1 ? Icons
                                  .radio_button_checked : Icons
                                  .radio_button_unchecked),
                            ),
                            title: Text('Date Created'),
                          ),
                          ListTile(
                            onTap: () {
                              setState((){
                                selectedSort['type'] = 2;
                                sortValue['type'] = 2;
                              });
                            },
                            leading: IconButton(
                              icon: Icon(sortValue['type'] == 2 ? Icons
                                  .radio_button_checked : Icons
                                  .radio_button_unchecked),
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
                            onTap: () {
                              setState((){
                                selectedSort['order'] = 0;
                                sortValue['order'] = 0;
                              });
                            },
                            leading: IconButton(
                              icon: Icon(sortValue['order'] == 0 ? Icons
                                  .radio_button_checked : Icons
                                  .radio_button_unchecked),
                            ),
                            title: Text('Ascending'),
                          ),
                          ListTile(
                            onTap: () {
                              setState((){
                                selectedSort['order'] = 1;
                                sortValue['order'] = 1;
                              });
                            },
                            leading: IconButton(
                              icon: Icon(sortValue['order'] == 1 ? Icons
                                  .radio_button_checked : Icons
                                  .radio_button_unchecked),
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
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
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
                                  onTap: () {
                                    Navigator.pop(context);
                                    return onTap(selectedSort);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
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
                  );
                }

            );
          }
      );
    } else if( type == DialogType.view)
      {
        //return a view widget
        return showDialog(context: context,
            builder: (context)
        {
          return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('View by', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),),
                        ListTile(
                          onTap: (){
                            setState((){
                              selectedSort['view'] = 0;
                              viewtype = 0;
                            });
                          },
                          leading: IconButton(
                            icon: Icon(viewtype == 0 ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                          ),
                          title: Text('Grid'),
                        ),

                        ListTile(
                          onTap: (){
                            setState((){
                              selectedSort['view'] = 1;
                              viewtype = 1;
                            });
                          },
                          leading: IconButton(
                            icon: Icon(viewtype == 1 ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                          ),
                          title: Text('List'),
                        ),
                        ListTile(
                          onTap: (){
                            setState((){
                              selectedSort['view'] = 2;
                              viewtype = 2;
                            });
                          },
                          leading: IconButton(
                            icon: Icon(viewtype == 2 ? Icons.radio_button_checked : Icons.radio_button_unchecked),
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
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
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
                                onTap: () {
                                  Navigator.pop(context);
                                  return onTap(selectedSort);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
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
                );
              }
          );
        });
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
