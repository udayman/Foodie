import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recipe/auth.dart';
import 'foodSearch.dart';
import 'notifier.dart';
import 'auth.dart';

class ItemDetail extends StatefulWidget {
  final String itemName;
  const ItemDetail(this.itemName);
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  Future callback;
  //Provider.of<Item>(context, listen: false).getItem();
  var showAll = false;
  var qty;
  var content="Add to Cart";
  void initState() {
    super.initState();
    print("a");
    qty = 0;
    var food = widget.itemName;
    callback = Provider.of<Info>(context, listen: false).getInfo(food);
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    print("ht"+height.toString());
    print("wt"+width.toString());
    return Scaffold(
        body: FutureBuilder(
            future: callback,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                throw snapshot.hasError;
              else if (!snapshot.hasData) {
                return Container();
              } else {
                var info = snapshot.data;
                print("image");
                print(info["hits"][0]["recipe"]["image"]);
                var ingr =
                info["hits"][0]["recipe"]["ingredientLines"].toString();
                print(ingr.length);
                return Container(
                  alignment: Alignment.center,
                  /*decoration: BoxDecoration(
                      border: Border.all(
                        //color: Colors.red,
                      )),*/
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin:  EdgeInsets.only(top:height*0.095),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      print("tap");
                                      Navigator.pop(context);
                                    });
                                  }),

                              /*  IconButton(
                                icon: Icon(Icons.shopping_cart),
                                color: Colors.black,
                                onPressed: () {
                                  print("tapped");
                                 /* Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => displayItem()));*/

                                },
                                //),
                                //)
                              )*/
                            ],
                          )),
                      Container(
                        width: width*0.51,
                        height: width*0.51,
                        padding: const EdgeInsets.all(0),
                        margin:  EdgeInsets.fromLTRB(0, height*0.02, 0, 0),
                        //border:color.red,
                        // alignment:Alignment.center,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
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
                      SizedBox(height: height*0.06),
                      Text(info["q"],
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: width*0.076)),
                      SizedBox(height: height*0.04),
                      Row(
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
                      ),

                      Container(
                          padding:  EdgeInsets.fromLTRB(width*0.051, 0,width*0.051 , 0),
                          child: Text.rich(TextSpan(children: <InlineSpan>[
                            TextSpan(
                                style: TextStyle(fontSize: width*0.04),
                                text: ingr.length > 150
                                    ? ingr.substring(0, 150) + "..."
                                    : ingr),

                          ]))
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: width*0.1,
                              width: width*0.1,
                              margin:  EdgeInsets.fromLTRB(0,height*0.020,width*0.08,0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 15,
                                      spreadRadius: -2,
                                    ),
                                  ]
                                // Boxshadow:
                              ),
                              child: IconButton(
                                  icon: Icon(Icons.remove),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      print("tap");
                                      if (qty > 0) qty = qty - 1;
                                    });
                                  })),
                          Text(qty.toString(), style: TextStyle(fontSize: width*0.051)),
                          Container(
                              height: width*0.1,
                              width: width*0.1,
                              margin: EdgeInsets.fromLTRB(width*0.08,height*0.020,0,0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 15,
                                      spreadRadius: -2,
                                    ),
                                  ]
                                // Boxshadow:
                              ),
                              child: IconButton(
                                  icon: Icon(Icons.add),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      print("tap");
                                      qty = qty + 1;
                                    });
                                  })),
                        ],
                      ),

                      //SizedBox(height:10),
                      //Spacer(),
                      Expanded(
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            margin:  EdgeInsets.fromLTRB(width*0.051,height*0.0271,width*0.051,height*0.0271),
                            child: ButtonTheme(
                              minWidth: width*0.765,
                              height: height*0.067,
                              child: RaisedButton(
                                color: Colors.lightGreen,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(18.0)),
                                child: Text(content,
                                    style: TextStyle(fontSize: width*0.038)),
                                splashColor: Colors.green,
                                onPressed: () async {

                                  setState(() {
                                    content="Added";
                                  });
                                  print("add");
                                  print(info["hits"][0]["recipe"]["text"]);
                                 // List as=["hg","jh"];
                                  //await DatabaseService(uid:user.uid).updateUser("h");
                                  await Provider.of<Info>(context).addFood(info["q"], qty, "serving",info["hits"][0]["recipe"]["image"],info["hits"][0]["recipe"]["ingredients"]);
                                   print("hg");
                                  /*Provider.of<Info>(context, listen: false)
                                      .AddFood(info["q"], qty, "serving");*/
                                  /*final snackBar=SnackBar(
                                    content: Text("Item added"),
                                  );*/
                                  //Scaffold.of(context).showSnackBar(snackBar);
                                  //Navigator.pop(context);
                                  //handleChange(finalFood, finalQty, "servings");
                                },
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
