import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recipe/auth.dart';

import 'firstscreen.dart';
import 'notifier.dart';

class Test extends StatefulWidget {
  final String itemName;
  const Test(this.itemName);
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Future callback;

  //Provider.of<Item>(context, listen: false).getItem();
  var showAll = false;
  var qty;
  var tester;
  var content="add";
  List<bool> isSelected = [true, false];

  List res = [];
  var selIndex = 0;
  double quantity = -1;
  void initState() {
    super.initState();
    print("a");
    qty = 0;
    tester = "as";
    var food = widget.itemName;
    callback = Provider.of<Info>(context, listen: false).getInfo(food);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //isSelected[0]=true;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    print("ht" + height.toString());
    print("wt" + width.toString());
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
              future: callback,
              // ignore: missing_return
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError)
                  throw snapshot.hasError;
                else if (!snapshot.hasData) {
                  return Container();
                } else {
                  var info = snapshot.data;
                  print("image");
                  print(info);
                  print(info["hits"][0]["recipe"]["image"]);
                  var ingr =
                      info["hits"][0]["recipe"]["ingredientLines"].toString();
                  List ingredients = Provider.of<Info>(context)
                      .getIngrDetails(info["hits"][0]["recipe"]["ingredients"]);
                  List nutrients = Provider.of<Info>(context).getNutrients(
                      info["hits"][0]["recipe"]["totalNutrients"]);
                  if (isSelected[0] == true) res = ingredients;
                  if (quantity < 0)
                    quantity = info["hits"][0]["recipe"]["yield"];

                  print("there si");
                  print(ingredients);
                  print(nutrients);
                  //print(info["hits"][0]["recipe"]["totalNutrients"]);
                  print("nk");

                  return Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: width,
                              height: width * 0.7,
                              padding: const EdgeInsets.all(0),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              //border:color.red,
                              // alignment:Alignment.center,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,

                                    //fit: BoxFit.fitHeight,
                                    //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8),BlendMode.dstATop),
                                    image: NetworkImage(
                                        info["hits"][0]["recipe"]["image"]),
                                  )
                                  // child: Image.network(info["hits"][0]["recipe"]["image"]),
                                  ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height * 0.009),
                              child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      print("tap");
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => MainMenu()));
                                      //Navigator.pop(context);
                                    });
                                  }),
                            ),
                          ],
                        )
                        /* Container(
                      margin:  EdgeInsets.only(top:height*0.095),
                      child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              print("tap");
                              Navigator.pop(context);
                            });
                          }),
                    ),
                    Container(

                      width: width ,
                      height: width * 0.7,
                      padding: const EdgeInsets.all(0),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //border:color.red,
                      // alignment:Alignment.center,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,

                            //fit: BoxFit.fitHeight,
                            //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8),BlendMode.dstATop),
                            image:
                                NetworkImage(info["hits"][0]["recipe"]["image"]),
                          )
                          // child: Image.network(info["hits"][0]["recipe"]["image"]),
                          ),
                    ),*/
                        ,

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          margin: EdgeInsets.only(top: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: width * 0.05),
                                child: Text(info["q"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.076)),
                              ),
                              //SizedBox(height: height*0.04),
                              /*Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          height: width*0.076,
                                          width:width*0.255,
                                          margin:  EdgeInsets.fromLTRB(width*0.076, 0, width*0.1, width*0.05),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            //border:Border.all(color:Colors.black),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(18)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.room_service,
                                                color: Colors.cyan,
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left: width*0.05),
                                                child: Text(info["hits"][0]["recipe"]
                                                ["yield"]
                                                    .toString()),
                                              )
                                            ],
                                          )),
                                      Container(
                                          height: width*0.076,
                                          width: width*0.255,
                                          margin: EdgeInsets.fromLTRB(width*0.0760, 0, width*0.1, width*0.05),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            //border:Border.all(color:Colors.black),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(18)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                MdiIcons.fire,
                                                color: Colors.pinkAccent,
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left: width*0.025),
                                                child: Text(info["hits"][0]["recipe"]
                                                ["calories"]
                                                    .toStringAsFixed(2)),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),*/
                            ],
                          ),
                        ),
                        /*Container(
                              height: 10,
                              child:NavigationToolbar(
                                leading: Text("as"),
                                //centerMiddle: true,
                                trailing: Text("As"),
                              )
                            ),*/
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                width * 0.1, 5, width * 0.1, 5),
                            child: Row(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    //margin:EdgeInsets.only(left: width*0.1),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    margin: EdgeInsets.fromLTRB(
                                        width * 0.1, 0, 20, 0),
                                    child: IconButton(
                                        icon: FaIcon(
                                          Icons.remove,
                                          color: Colors.green,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (quantity > 0)
                                              quantity = quantity - 1;
                                          });
                                        })),
                              ),
                              Container(
                                  child: Text(quantity.toStringAsFixed(2),
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 18))),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: IconButton(
                                        icon: FaIcon(
                                          Icons.add,
                                          color: Colors.green,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            quantity = quantity + 1;
                                            print(quantity);
                                          });
                                        })),
                              ),
                            ])),

                        /*        Padding(
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

                                        })),
                              ),
                  ])),
                  Container(
                      child: Text(
                          info["hits"][0]["recipe"]
                          ["yield"]
                              .toStringAsFixed(
                              2),
                          style: TextStyle(
                              color: Colors
                                  .green))),
                              ])
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

                                      })),
                            ),
                            ]),*/
                        Container(
                          child: Row(
                            children: <Widget>[
                              ToggleButtons(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: isSelected[0] == true
                                                    ? 3
                                                    : 0,
                                                color: isSelected[0] == true
                                                    ? Colors.red
                                                    : Colors.white))),
                                    margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: Text("Ingredients",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: isSelected[0] == true
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: 18)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: isSelected[1] == true
                                                    ? 3
                                                    : 0,
                                                color: isSelected[1] == true
                                                    ? Colors.red
                                                    : Colors.white))),
                                    margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: Text("Nutrients",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: isSelected[1] == true
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: 18)),
                                  )
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int buttonIndex = 0;
                                        buttonIndex < isSelected.length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        isSelected[buttonIndex] = true;
                                        // res=ingredients;
                                      } else {
                                        isSelected[buttonIndex] = false;
                                        // res=nutrients;
                                      }
                                    }
                                    if (index == 0)
                                      res = ingredients;
                                    else
                                      res = nutrients;
                                  });
                                },
                                selectedColor: Colors.black,
                                //selectedBorderColor: Colors.redAccent,
                                //textStyle:TextStyle(fontWeight:FontWeight.bold),
                                isSelected: isSelected,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Expanded(
                              child: ListView.builder(
                                  itemCount: res.length,
                                  itemBuilder: (_, int position) {
                                    var item = res.elementAt(position);
                                    return Container(
                                        margin: EdgeInsets.fromLTRB(
                                            width * 0.04,
                                            width * 0.02,
                                            0,
                                            width * 0.02),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  //border: Border.all(),
                                                  ),
                                              width: width * 0.5,
                                              child: Text(
                                                item["Name"]
                                                        .toString()
                                                        .substring(0, 1)
                                                        .toUpperCase() +
                                                    item["Name"]
                                                        .toString()
                                                        .substring(1)
                                                        .toLowerCase(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                                width: width * 0.4,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(),
                                                    ),
                                                //margin:EdgeInsets.only(left: width*0.4),
                                                child: Text(
                                                  (item["Qty"] *
                                                              quantity /
                                                              info["hits"][0]
                                                                      ["recipe"]
                                                                  ["yield"])
                                                          .toStringAsFixed(2) +
                                                      " " +
                                                      item["uom"],
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black38),
                                                  textAlign: TextAlign.right,
                                                ))
                                          ],
                                        )
                                        // child: Text(item["Name"],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

                                        );
                                  })),
                        ),
                        //Padding(
                        //padding: EdgeInsets.all(0),
                        Container(
                            alignment: Alignment.bottomCenter,
                            margin:  EdgeInsets.fromLTRB(width*0.051,height*0.0271,width*0.051,height*0.0271),
                            //decoration: BoxDecoration(border: Border.all()),
                            //height: 45,
                            // width: width,
                            child: ButtonTheme(
                              minWidth: width * 0.765,
                              height: height * 0.067,
                              child: RaisedButton(
                                color: Colors.lightGreen,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(18.0)),
                                child: Text(content,
                                    style: TextStyle(fontSize: width * 0.038)),
                                onPressed: () async {
                                  setState(() {
                                    content="Added";
                                  });
                                  await Provider.of<Info>(context).addFood(info["q"], quantity.toInt(), "serving",info["hits"][0]["recipe"]["image"],info["hits"][0]["recipe"]["ingredients"]);
                                },
                              ),
                            ))

                        /*TextField(
                                            textAlign: TextAlign.left,
                                           // controller: _textController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Servng"
                                            ),
                                          ),*/

                        /*InkWell(
                                    child: FlatButton(
                                      padding: EdgeInsets.all(8.0),
                                      onPressed: () {
                                        setState(() {
                                          tester="adfs";
                                          print(tester);
                                        });

                                        /*...*/
                                      },

                                      child: Text(

                                        "Ingredients",

                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: FlatButton(
                                      padding: EdgeInsets.all(8.0),
                                      onPressed: () {
                                        setState(() {
                                          tester="asd";
                                          print(tester);
                                        });

                                        /*...*/
                                      },
                                      child: Text(
                                        "Nutrients",
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  )*/

                        //Text(tester),
                      ]));
                }
              })),
    );
  }
}
