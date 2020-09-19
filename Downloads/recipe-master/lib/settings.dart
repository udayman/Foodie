import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recipe/sign_in.dart';

import 'notifier.dart';
//import 'main_menu.dart';
//import 'user_profile.dart';

class Settings extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Your Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Color color = Colors.green[500];

    Widget listButtonSection = Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          //do something
          Provider.of<Info>(context, listen: false)
              .deleteAll();
        },
        color: Colors.grey,
        child: Row(children: <Widget>[
          Text("Clear Your Existing Lists",
            style: TextStyle(fontSize: 18),),
        ],
        ),
      ),
    );

    Widget changeNameSection = Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          //do something
        },
        color: Colors.grey,
        child: Row(children: <Widget>[
          Text("Change Your Profile Name",
            style: TextStyle(fontSize: 18),),
        ],
        ),
      ),
    );

    Widget changeProfilePicSection = Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          //do something
        },
        color: Colors.grey,
        child: Row(children: <Widget>[
          Text("Change Your Profile Picture",
            style: TextStyle(fontSize: 18),),
        ],
        ),
      ),
    );

    Widget logoutSection = Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          signOutGoogle();
          //Navigator.popUntil(context, ModalRoute.withName("/"));
          Navigator.pushNamed(context,'/');
          //do something
        },
        color: Colors.grey,
        child: Row(children: <Widget>[
          Text("Logout",
            style: TextStyle(fontSize: 18),),
        ],
        ),
      ),
    );

    Widget foodButtonSearchSection = Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          Navigator.pop(context);
          // runApp(MainMenu());
        },
        color: Colors.grey,
        child: Row(children: <Widget>[
          Text("Return to Food Search",
            style: TextStyle(fontSize: 18),),
        ],
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          leading: IconButton(
            icon: Icon(
              Icons.portrait,
              color:Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'user');
              // runApp(UserProfile());
            },
          ),
          title: Text(''),
        ),
        body: ListView(
          children: [
            titleSection,
            foodButtonSearchSection,
            listButtonSection,
            changeNameSection,
            changeProfilePicSection,
            logoutSection,
          ],
        ),
      ),
    );
  }


}