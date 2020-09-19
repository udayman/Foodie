import 'package:flutter/material.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'What will you eat today?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Your desired meal"
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Desired Unit of Measurement',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:18,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Your unit"
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.filter_1, 'All'),
          _buildButtonColumn(color, Icons.filter_2, 'Main Food'),
          _buildButtonColumn(color, Icons.filter_3, 'Desserts'),
          _buildButtonColumn(color, Icons.filter_4, 'Drinks')
        ],
      ),
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
              //do something
            },
          ),
          title: Text(''),
          actions: <Widget>[ 
            IconButton(
              icon: Icon(
                Icons.portrait,
                color: Colors.white,
              ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
        body: ListView(
          children: [
            titleSection,
            buttonSection,
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
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
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
