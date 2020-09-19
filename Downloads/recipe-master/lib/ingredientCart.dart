import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
//import 'package:share/share.dart';

import 'notifier.dart';

class ingredientList extends StatefulWidget {
  //final String itemName;
  //const Display(this.itemName);
  State<ingredientList> createState() => _IngredientState();
}

class _IngredientState extends State<ingredientList> {
  bool isChecked = false;
  Info parent;

  //var totIngr=finalFood;+
  //var totIngr = Provider.of<Item>(context);
  void toggleCH(bool value) {
    if (isChecked == false) {
      setState(() {
        isChecked = true;
      });
    } else {
      setState(() {
        isChecked = false;
      });
    }
  }

  //List key=[false,true,false];
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    var share="";
    //List keys = Provider.of<Info>(context, listen: false).keys;
    //print(keys);
    String ingrName = "", ingrUOM = "";
    double ingrQty = 0;
    bool _isChecked = true;
    // var map1 = Map.fromIterable(list, key: (e) => e.name, value: (e) => false);
    return Scaffold(
        body: SafeArea(
          child: Column(children: <Widget>[
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Provider.of<Info>(context).getIngr(),
                  builder: (context, snapshot) {
                    if (snapshot == null) {
                      return Text("List is empty");
                    }
                    else {
                      if (snapshot.data.documents.length == 0)
                        return Text("List is empty");
                      else {
                        print(snapshot.data.toString());
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (_, int position) {
                              DocumentSnapshot item = snapshot.data
                                  .documents[position];
                              print(item.documentID);
                              // ignore: deprecated_member_use
                              share += item.documentID + " " +
                                  item.get("qty").toStringAsFixed(2) + " " +
                                  item.get("uom") + "\n";
                              //var name = items["ingrName"];
                              return Builder(
                                builder: (context) =>
                                (Dismissible(
                                    key: Key(item.documentID),
                                    onDismissed: (direction) {
                                      // Remove the item from the data source.
                                      setState(() {
                                        Provider.of<Info>(
                                            context, listen: false)
                                            .handleIngr(
                                            item.documentID, item.get("qty"), 0);
                                      });
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                '$item.docuementId deleted'),
                                            duration: Duration(seconds: 3),
                                          ));
                                    },

                                    // Show a red background as the item is swiped away.
                                    background: Container(color: Colors.red),
                                    child:
                                    //SingleChildScrollView(
                                    //scrollDirection: Axis.horizontal,
                                    //child: Row(
                                    // children: <Widget>[
                                    Container(
                                      constraints: BoxConstraints(
                                          maxHeight: double.infinity,
                                          minHeight: 100),
                                      // margin:const EdgeInsets.fromLTRB(0,20,0,20),
                                      //height: 120,

                                      child: Row(children: <Widget>[
                                        Checkbox(
                                          value: item.get("key"),
                                          onChanged: (bool val) {
                                            print("change");
                                            print(position);
                                            print(item.get("key"));
                                            // if(.get("key")eys[position]==true) {
                                            print(item.get("key"));
                                            setState(() {
                                              print(item.get("key"));
                                              bool val = false;
                                              if (item.get("key") == false)
                                                val = true;
                                              else
                                                val = false;
                                              Provider.of<Info>(
                                                  context, listen: false)
                                                  .toggleCheck(
                                                  item.documentID, val);
                                            });
                                          },
                                          activeColor: Colors.green,
                                          checkColor: Colors.white,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 20, 0, 0),
                                          child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Container(
                                                    width: 250,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Text(item.documentID,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold))
                                                        ])),
                                                Row(children: <Widget>[
                                                  Container(
                                                    width: 175,
                                                    margin: const EdgeInsets
                                                        .fromLTRB(
                                                        0, 5, 0, 15),
                                                    child: Text(
                                                        item.get("qty")
                                                            .toStringAsFixed(
                                                            2) +
                                                            "  " +
                                                            item.get("uom"),
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .all(
                                                        0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.green,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                        ),
                                                        margin:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 20, 0),
                                                        child: IconButton(
                                                            icon: FaIcon(
                                                              Icons.remove,
                                                              color: Colors
                                                                  .green,
                                                              size: 12,
                                                            ),
                                                            onPressed: () {
                                                              Provider.of<Info>(
                                                                  context,
                                                                  listen: false)
                                                                  .handleIngr(
                                                                  item
                                                                      .documentID,
                                                                  -1,
                                                                  -1);
                                                            })),
                                                  ),
                                                  Container(
                                                      child: Text(
                                                          item.get("qty")
                                                              .toStringAsFixed(
                                                              2),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .green))),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .all(
                                                        0),
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.green,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                        ),
                                                        margin:
                                                        EdgeInsets.fromLTRB(
                                                            20, 0, 20, 0),
                                                        child: IconButton(
                                                            icon: Icon(
                                                              Icons.add,
                                                              color: Colors
                                                                  .green,
                                                              size: 12,
                                                            ),
                                                            onPressed: () {
                                                              Provider.of<Info>(
                                                                  context,
                                                                  listen: false)
                                                                  .handleIngr(
                                                                  item
                                                                      .documentID,
                                                                  1,
                                                                  1);
                                                            })),
                                                  ),
                                                ])
                                              ]),
                                        ),

                                        //Text:Text(),
                                      ]),
                                    ))),
                              );
                            });
                      }
                    }
                  })),
            Container(
              height: height*0.09,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin:  EdgeInsets.fromLTRB(width*0.05, 0, 0, width*0.05),
                      child: FloatingActionButton(
                        heroTag: "btnadd",
                        onPressed: () {

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Container(
                                    height: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Enter Ingredient Name',
                                                ),
                                                onChanged: (text) {
                                                  ingrName = text;
                                                }),
                                            TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Enter Ingredient Quantity',
                                                ),
                                                onChanged: (text) {
                                                  ingrQty = double.parse(text);
                                                }),
                                            TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Enter Ingredient UOM',
                                                ),
                                                onChanged: (text) {
                                                  ingrUOM = text;
                                                }),
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              margin: EdgeInsets.only(top: 10),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  print(ingrQty);
                                                  print(ingrName);
                                                  print(ingrUOM);
                                                 Provider.of<Info>(context, listen: false)
                                                      .addnewIngr(ingrName, ingrQty, ingrUOM);
                                                 /* totIngr.addIngr(
                                                      ingrName, ingrQty, ingrUOM);*/
                                                 Navigator.of(context).pop();
                                                },
                                                child: Text("Save"),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                );
                              });
                          // Add your onPressed code here!
                        },
                        child: Icon(Icons.add,color: Colors.white,),
                        backgroundColor: Colors.lightGreen,
                        focusColor: Colors.green,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(width*0.05, 0, 0, width*0.05),
                      child: FloatingActionButton(
                        heroTag: "btnshare",
                        onPressed: () {
                          String res="";
                          final RenderBox box = context.findRenderObject();



                          Share.share(share,
                              subject: "Ingredients",
                              sharePositionOrigin:
                              box.localToGlobal(Offset.zero) &
                              box.size);
                          // Add your onPressed code here!
                        },
                        child: Icon(Icons.share,color: Colors.white,),
                        backgroundColor: Colors.lightGreen,
                        focusColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* Container(
            height: 50,
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 20),
            child: ButtonTheme(
              minWidth: 300,
              height: 50,
              child: RaisedButton(
                color: Colors.lightGreen,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0)),
                child: Text('Add Ingredients', style: TextStyle(fontSize: 15)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Ingredient Name',
                                        ),
                                        onChanged: (text) {
                                          ingrName = text;
                                        }),
                                    TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Ingredient Quantity',
                                        ),
                                        onChanged: (text) {
                                          ingrQty = double.parse(text);
                                        }),
                                    TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Ingredient UOM',
                                        ),
                                        onChanged: (text) {
                                          ingrUOM = text;
                                        }),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      margin: EdgeInsets.only(top: 10),
                                      child: RaisedButton(
                                        onPressed: () {
                                          print(ingrQty);
                                          print(ingrName);
                                          totIngr.addIngr(
                                              ingrName, ingrQty, ingrUOM);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Save"),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        );
                      });
                },
              ),
            ))*/
          ]),
        ));
  }
}
