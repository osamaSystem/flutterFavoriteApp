import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newflutterapp/database/Helper.dart';
import 'package:newflutterapp/model/User.dart';
import 'package:newflutterapp/utils/Utils.dart';

class MyFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyFavoritePage(title: 'Favorite Contacts');
  }
}

class MyFavoritePage extends StatefulWidget {
  MyFavoritePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyFavoritePageState createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  bool insertItem = false;
  List<User> items = new List();
  List<User> values;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getFavoriteUsers(),
    );
  }

  @override
  void initState() {
    super.initState();
    print("INIT");
    _scrollController = new ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  /// Get all users data
  getFavoriteUsers() {
    return FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return createListView(context, snapshot);
        });
  }

  ///Fetch data from database
  Future<List<User>> _getData() async {
    var dbHelper = Helper();
    await dbHelper.getFavoriteUsers().then((value) {
      items = value;
      if (insertItem) {
        _listKey.currentState.insertItem(values.length);
        insertItem = false;
      }
    });

    return items;
  }

  ///create List View with Animation
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    values = snapshot.data;
    if (values != null) {
      showProgress();
      return new AnimatedList(
          key: _listKey,
          controller: _scrollController,
          shrinkWrap: true,
          initialItemCount: values.length,
          itemBuilder: (BuildContext context, int index, animation) {
            return _buildItem(values[index], animation, index);
            //return;
          });
    } else
      return Container();
  }

  ///Construct cell for List View
  Widget _buildItem(User values, Animation<double> animation, int index) {
    int v = values.favorite;
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          onTap: () => {},
          title: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.brown.shade800,
                      child: Text(
                        values.name.substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 5.0)),
                  new Row(
                    children: <Widget>[
                      Icon(Icons.account_circle),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                      new InkWell(
                        child: Container(
                          constraints: new BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width - 200),
                          child: Text(
                            values.name,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontStyle: FontStyle.normal,
                                color: Colors.black),
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0)),
                  new Row(
                    children: <Widget>[
                      Icon(Icons.phone),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                      new InkWell(
                        child: new Text(
                          values.phone.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0)),
                  new Row(
                    children: <Widget>[
                      Icon(Icons.email),
                      Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                      new InkWell(
                        child: Container(
                          constraints: new BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width - 200),
                          child: new Text(
                            values.email.toString(),
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 10.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///On Item Click
}
