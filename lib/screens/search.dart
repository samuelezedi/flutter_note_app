
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:notably/components/page_transition.dart';
import 'package:notably/components/search_service.dart';
import 'package:notably/screens/create.dart';
import 'package:notably/utils/theme.dart';

class SearchNotes extends StatefulWidget {
  var user;
  SearchNotes(this.user);
  @override
  _SearchNotesState createState() => _SearchNotesState();
}

class _SearchNotesState extends State<SearchNotes> {

  var userId;
  var type;

  bool showSearching = false;

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {

//    var capitalisedValue = value.substring(0,1).toUpperCase() + value.substring(1);

      tempSearchStore = [];

        queryResultSet.forEach((element) {

          if (element.data['title'].startsWith(value.toString().toLowerCase()) ||
              element.data['title'].startsWith(value.toString().toUpperCase())) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      queryResultSet = [];
      tempSearchStore = [];
      showSearching = false;
    });
    SearchService.searchByName(widget.user).then((docs){
      for(int i = 0; i <docs.documents.length; i++){
        queryResultSet.add(docs.documents[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.linearGradient
          ),
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          width: double.infinity,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[300]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          )),
                      Container(

                          width: MediaQuery.of(context).size.width * 0.80,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            onChanged: (input) {
                              initiateSearch(input);
                            },
                            autofocus: true,
                            style: TextStyle(
                                fontSize: 17
                            ),
                            decoration: InputDecoration(
                                hintText: 'Search e.g. GST101',
                                contentPadding: EdgeInsets.only(top: 10),
                                suffixIcon: Icon(FeatherIcons.search),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                )
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(

                    [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Search Results : ' + this.tempSearchStore.length.toString(),
                              style: TextStyle(
                                  fontSize: 14
                              ),
                            ),
                          ),

                        ],
                      )
                    ]

                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                    tempSearchStore.isEmpty ? [showWarning()] :
                    tempSearchStore.map((element){
                      return buildCard(element);
                    }).toList()

                ),
              ),

            ],
          )

      ),
    );
  }

  showWarning() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 120,
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'No Search Yet!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildCard (element) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, PageTransition.scaleRoute(page: CreateNote(
          widget.user,
          element.documentID,
          noteContent: element.data['content'],
          noteTitle: element.data['title'],
          created: element.data['timestamp'],
          updated: element.data['updated'],
        )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),
        child: Container(
          height: 130,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    element.data['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Text(
                  element.data['content'],
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
