import 'package:flutter/material.dart';
import 'package:recipe/auth.dart';
/*import 'package:provider/provider.dart';
import 'foodSearch.dart';
import 'notifier.dart';*/
//import 'food_search.dart';

class MainMenu extends StatefulWidget {
  @override
  MainMenuState createState() => new MainMenuState();

}

class MainMenuState extends State<MainMenu> {
  var _textController = new TextEditingController();
  @override
  //var userid="";


  Widget build(BuildContext context) {
    //var userId=Provider.of<Info>(context).id;
    print("first");
    //print(userId);
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
                  padding: const EdgeInsets.only(bottom: 32),
                  child:
                  Align(
                    alignment: Alignment.center,
                    child: new Image(
                      image: new AssetImage("assets/changedfoodie.png"),
                      height: 200,
                      width: 300,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.center,
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
                    controller: _textController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Your desired meal"
                    ),
                  ),
                ),
                new ListTile(
                  title: new RaisedButton(
                    child: new Text("Enter value"),
                    onPressed: () {
                      DatabaseService().addData(['sa']);
                      Navigator.pushNamed(context, 'foodSearch',arguments:_textController.text );
                      //Navigator.of(context).pushNamed('foodSearch',);
                      /*  var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new FoodSearch(value: _textController.text),
                      );
                      Navigator.of(context).push(route);*/
                    },
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          /*Expanded(
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
                new ListTile(
                  title: new RaisedButton(
                    child: new Text("Enter value"),
                    onPressed: () {
                      //do nothing
                    },
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );

    Color color = Colors.lightGreen;

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
          Navigator.pushNamed(context, 'cart');
          //do something
        },
        color: Colors.grey,
      //  child: Row(children: <Widget>[
         child: Align(
            alignment: Alignment.center,
            child: Text("Access Your Existing Lists",
              style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
          ),
       /* ],
        ),*/
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
              Navigator.pushNamed(context, 'settings');
              //do something
            },
          ),
          title: Text(''),
          actions: <Widget>[
            /*IconButton(
        icon: Icon(
          Icons.shopping_cart,
         // icon: Icon(Icons.shopping_cart),
          color: Colors.white,

        ),
          onPressed: (){
          Navigator.pushNamed(context, 'cart');
          },
        ),*/
            IconButton(
              icon: Icon(
                Icons.portrait,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'user');
                // runApp(UserProfile());
              },
            )
          ],
        ),
        body: ListView(
          children: [
            titleSection,

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