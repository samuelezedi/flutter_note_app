
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:notably/components/search_service.dart';

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

    if(value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
        showSearching = false;
      });
    }
//    var capitalisedValue = value.substring(0,1).toUpperCase() + value.substring(1);
    if(queryResultSet.length == 0 && value.length == 1) {
      SearchService.searchByName(widget.user).then((docs){
        for(int i = 0; i <docs.documents.length; i++){
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if(element['title'].startsWith(value)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

          margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
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
                            textCapitalization: TextCapitalization.characters,
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

      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    element['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                element['content'],
                style: TextStyle(
                    fontSize: 18
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
