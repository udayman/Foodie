import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firstscreen.dart';
import 'notifier.dart';
import 'settings.dart';

class UserProfile extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    var photo= Provider.of<Info>(context).getPhoto();
    print( Provider.of<Info>(context).getPhoto(),);
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
                      Provider.of<Info>(context).getName(),
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

    Widget buttonSection = Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(


        shape: BoxShape.circle,

        image: new DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(photo),
        )
      ),
      /*child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

         // _buildButtonColumn(color, Icons.portrait, 'Profile Picture'),
        ],
      ),*/
    );

    Widget listButtonSection = Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          //do something
        },
        color: Colors.grey,
        child: Row(children: <Widget>[
          Text("Access Your Existing Lists",
            style: TextStyle(fontSize: 18),),
        ],
        ),
      ),
    );

    Widget foodButtonSearchSection = Container(
      padding: EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainMenu()));
          //runApp(MainMenu());
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
              Icons.settings,
              color:Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              //  runApp(Settings());
            },
          ),
          title: Text(''),
        ),
        body: Column(
          children: [
            titleSection,
            buttonSection,
            foodButtonSearchSection,
            listButtonSection,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 50.0, color: color),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}