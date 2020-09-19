import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifier.dart';

// ignore: camel_case_types
class itemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var items = Provider.of<Info>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(height);
    print(width.toString() + "s");
    // items.getItem();
    return Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //Padding :const EdgeInsets.all(30),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.025, height * 0.05, 0, 0),
                      child: IconButton(
                          icon: Icon(Icons.navigate_before),
                          color: Colors.black,
                          onPressed: () {}),
                    ),
                    Spacer(),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        height: 80,
                        width: 80,
                        // color:Colors.grey[300],
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: IconButton(
                          onPressed: ()
                          {
                            Provider.of<Info>(context).deleteAll();
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.black,
                        )),
                  ],
                ),
                // Text("Saved Items"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,5),
                child: Text("My Items",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream:  Provider.of<Info>(context).getFood(),
                   // stream: Firestore.instance.collection('User_History').document(uid).collection('Food_List').snapshots(),
                    builder: (context, snapshot) {
                      print(snapshot.toString());
                      if(snapshot==null)
                        return Text("List id empty");
                      else {
                        print(snapshot.data.toString());
                        print("data");
                        print(snapshot.data.docs[0].id);
                        //print(values.length);
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (_, int position) {
                            DocumentSnapshot item = snapshot.data
                                .docs[position];
                            print(item.id);
                            //print(d)
                            print(item.id);
                            print(item.data);
                            print(item.get("qty").toString());
                            print(item.toString());
                            //var item=snapshot.data.documents[position];
                            print(item);

                            print("item");
                            //var item = items.foodList.elementAt(position);
                            //    (snapshot.data["Saved_Items"]).toList();

                            return
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 125,
                                          /*decoration: BoxDecoration(
                       border: Border.all(),
                      color: Colors.red,
               ),*/
                                          constraints: BoxConstraints(
                                              maxWidth: double.infinity,
                                              minWidth: width),


                                          child: Card(

                                            child: InkWell(
                                              onTap: () {
                                                print("tapped");
                                                /* Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DisplayItem(item["foodName"])));
                                */
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Row(children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: new DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: new NetworkImage(
                                                              item.get("image")==
                                                                  null
                                                                  ? ""
                                                                  : item.get("image")),
                                                        )),
                                                    margin: EdgeInsets.all(8),
                                                    //alignment: Alignment.centerRight,
                                                    height: 60,
                                                    width: 60,
                                                  ),
                                                  // title:Text("emp"+item["Item"]),
                                                  Column(
                                                    //margin:co
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Padding(
                                                          padding: const EdgeInsets
                                                              .only(left: 25),
                                                          child: new Text(
                                                              item.documentID,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              style: new TextStyle(
                                                                  fontFamily: 'Roboto',
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .lightGreen,
                                                                  fontSize: 20))),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            25, 10, 20, 0),
                                                        child: Text(
                                                            item.get("qty")
                                                                .toString() +
                                                                " " +
                                                                item.get("serving"),
                                                            style: new TextStyle(
                                                              fontSize: 12,
                                                            )),
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: () {
                                                              Provider.of<Info>(
                                                                  context)
                                                                  .handleFood(
                                                                  item
                                                                      .documentID,
                                                                  1, 1);
                                                              /* Provider.of<Info>(context, listen: false)
                                                                .incrementFood(
                                                                item["foodName"], position);*/
                                                            },
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.add,
                                                                size: width *
                                                                    0.05,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Provider.of<Info>(
                                                                  context)
                                                                  .handleFood(
                                                                  item
                                                                      .documentID,
                                                                  -item.get("qty"),
                                                                  0);
                                                              /* Provider.of<Info>(context, listen: false)
                                                                .deleteFood(item["foodName"],
                                                                item["foodQty"], position);*/
                                                            },
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.delete,
                                                                size: width *
                                                                    0.05,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Provider.of<Info>(
                                                                  context)
                                                                  .handleFood(
                                                                  item
                                                                      .documentID,
                                                                  -1, -1);
                                                              /*  Provider.of<Info>(context, listen: false)
                                                                .decrementFood(
                                                                item["foodName"], position);*/
                                                            },
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.remove,
                                                                size: width *
                                                                    0.05,
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                  context)
                                                                  .pushNamed(
                                                                  'youTube',
                                                                  arguments: item
                                                                      .documentID);
                                                            },
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .play_circle_outline,
                                                                color: Colors
                                                                    .red,
                                                                size: width *
                                                                    0.05,
                                                              ),
                                                            ),
                                                          )
                                                          /* IconButton(
                                                     icon: Icon(
                                                       Icons.remove,
                                                     ),

                                                   )*/
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                              ),
                                            ),
                                            elevation: 1,
                                          ),
                                        )
                                      ]));
                          },
                        );
                      }}
                  ),
                ),
              ),
              Container(
                  height: width*0.2,
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ButtonTheme(
                    minWidth: width*0.76,
                    height: width*0.15,
                    child: RaisedButton(
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0)),
                      child: Text('Continue', style: TextStyle(fontSize: 17)),
                      onPressed: () {
                        print("add");
                        /* Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Ingr()));*/
                        Navigator.pushNamed(context, 'ingredientList');
                        //Provider.of<Item>(context, listen: false).AddFood(info["q"], qty, "serving");
                        //handleChange(finalFood, finalQty, "servings");
                      },
                    ),
                  ))
            ],
          ),
        ));
    // TODO: implement build
    return null;
  }
}
