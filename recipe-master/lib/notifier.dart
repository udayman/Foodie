import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Info extends ChangeNotifier {
   String uid;
   String name;String photo;
   String getName()
   {
     return this.name;
   }
   String getPhoto()
   {
     return this.photo;
   }
   final CollectionReference user_history=Firestore.instance.collection("User_History");
   //user_history.document(uid).collection('Food_List').snapshots();
   Stream<QuerySnapshot> getFood()
   {
     print(uid);

     return user_history.doc(uid).collection('Food_List').snapshots();
   }
   Stream<QuerySnapshot> getIngr()
   {
     print(uid);
     return user_history.doc(uid).collection('Ingr_List').snapshots();
   }
   Future<void> toggleCheck(String ingr,bool value)
   {
     print(user_history.doc(uid).collection('Ingr_List').document(ingr).updateData({'key':value}));
   }
   Future<void> getDetails(String uid,String name,String photo)
   async {
     this.uid=uid;
     this.name=name;
     this.photo=photo;
     print("this is the uid"+this.uid);
     print(this.uid);
     print(this.name);
     print("noid");
      await user_history.document(uid).setData({});
    /*await  print(user_history.document(uid).collection('Food_List').getDocuments());
      await print(user_history.document(uid).collection('Food_List').toString());
    await user_history.document(uid).collection('Food_List').getDocuments().then((value) => print(value.documents.length));
    print( user_history.document(uid).collection('Food_List').snapshots().length.toString());
    print("above");
     await user_history.document(uid).collection('Food_List').document().setData({},merge: true);*/
      //await user_history.document(uid).collection("Food").document("hello");
   }
   Future<void> addnewIngr(String ingr,double qty,String uom)
   {
     print(ingr+" "+qty.toString()+" "+uom);
     user_history.document(uid).collection('Ingr_List').document(ingr).setData({
       'qty':FieldValue.increment(qty),
       'uom':uom,
       'key':false,
     },SetOptions(merge: true));
   }
   Future<void> deleteAll() async
   {
     user_history.document(uid).collection('Food_List').getDocuments().then((snapshot) {
       for (DocumentSnapshot ds in snapshot.documents){
         ds.reference.delete();
       }});
     user_history.document(uid).collection('Ingr_List').getDocuments().then((snapshot) {
       for (DocumentSnapshot ds in snapshot.documents){
         ds.reference.delete();
       }});


   }
   Future<void> handleIngr(String ingr,double qty,int flag) async
   {
     if(flag==0)
      await user_history.document(uid).collection('Ingr_List').document(ingr).delete();
     else{
     await user_history.document(uid).collection('Ingr_List').document(ingr).updateData({'qty':FieldValue.increment(qty)});
     DocumentSnapshot ds=await user_history.document(uid).collection('Ingr_List').document(ingr).get();
     if(ds.get("qty")<=0)
       await user_history.document(uid).collection('Ingr_List').document(ingr).delete();
     }
   }
 Future<void> handleFood(String food,int qty,int flag)
 async {
     print(qty);
     user_history.document(uid).collection('Food_List').document(food).updateData({'qty':FieldValue.increment(qty)});
     print("heyyy");
     print( user_history.document(uid).collection('Food_List').document(food).documentID);
     print("yg");
     DocumentSnapshot ds=await user_history.document(uid).collection('Food_List').document(food).get();
     print(ds.toString());
     print(ds.get("qty"));
     if(ds.get("qty")==0)
       await user_history.document(uid).collection('Food_List').document(food).delete();
     print("hg");
   var url =
       "https://api.edamam.com/search?q=$food&app_id=4846916e&app_key=6cf0bbb58cd6ab83f3c56eeccf51cb1a&";
   final response = await http.get(url);
   var responseJson = jsonDecode(response.body.toString());
   print("response");
   print(responseJson);
   print(responseJson["hits"][0]["recipe"]["ingredients"]);
   await addIngr(responseJson["hits"][0]["recipe"]["ingredients"],qty,flag);
 }

  Future<void> addFood(String food,int qty,String serving,String image,List<dynamic> ingr)
  async {
    List as=[1,2];
    print(uid);
    print("this is uuid");
  user_history.document(uid).collection('Food_List').document(food).setData({
    'qty':FieldValue.increment(qty),
    'serving':serving,
    'image':image,
  },SetOptions(merge: true));
 await addIngr(ingr,qty,1);
 // user_history.document(uid).collection('Food_List').document('pizza').updateData({'no':FieldValue.increment(25)});
   //user_history.document(uid).setData({'Fsa':"ads"},merge: true);
   //user_history.document(uid).setData({},merge: true);
    //user_history.document(uid).updateData({"Food_List":FieldValue.arrayUnion([3,4])});
  }
 List<dynamic> getIngrDetails(List<dynamic> ingr) {
    print(ingr);
    List res=[];
    //print("Add"+qtyfood.toString());
    for (int i = 0; i < ingr.length; i++) {
      //var ingredient=ingr.elementAt(i);
      String line = ingr.elementAt(i)["text"].toString();
      int j = line.indexOf(",");
      String actualIng;
      if (j == -1)
        actualIng = line;
      else
        actualIng = line.substring(0, j);
      print(actualIng);
      List<String> actual = actualIng.split(" ");
      print(actual);
      print(actual.length);
      int index = actual.length - 1;
      print(actual.elementAt(index));
      String uom = "number";
      int k,
          startindex = 0;
      for (k = 0; k < index; k++) {
        print("uomc" + actual.elementAt(k));
        if (actual.elementAt(k).toLowerCase() == "ounce" ||
            actual.elementAt(k).toLowerCase() == "gram" ||
            actual.elementAt(k).toLowerCase() == "pound" ||
            actual.elementAt(k).toLowerCase() == "kilogram" ||
            actual.elementAt(k).toLowerCase() == "pinch" ||
            actual.elementAt(k).toLowerCase() == "liter" ||
            actual.elementAt(k).toLowerCase() == "gallon" ||
            actual.elementAt(k).toLowerCase() == "pint" ||
            actual.elementAt(k).toLowerCase() == "millileter" ||
            actual.elementAt(k).toLowerCase() == "drop" ||
            actual.elementAt(k).toLowerCase() == "cup" ||
            actual.elementAt(k).toLowerCase() == "cups" ||
            actual.elementAt(k).toLowerCase() == "tablespoon" ||
            actual.elementAt(k).toLowerCase() == "tablespoons" ||
            actual.elementAt(k).toLowerCase() == "bunch" ||
            actual.elementAt(k).toLowerCase() == "tbsp" ||
            actual.elementAt(k).toLowerCase() == "tsp" ||
            actual.elementAt(k).toLowerCase() == "g" ||
            actual.elementAt(k).toLowerCase() == "piece" ||
            actual.elementAt(k).toLowerCase() == "pieces" ||
            actual.elementAt(k).toLowerCase() == "oz" ||
            actual.elementAt(k).toLowerCase() == "slice" ||
            actual.elementAt(k).toLowerCase() == "tbsp" ||
            actual.elementAt(k).toLowerCase() == "slices" ||
            actual.elementAt(k).toLowerCase() == "ounce" ||
            actual.elementAt(k).toLowerCase() == "ounces" ||
            actual.elementAt(k).toLowerCase() == "teaspoon") {
          uom = actual.elementAt(k);
          print("uom" + actual.elementAt(k));
          print(k);
          //print(startindex);
          //if (startindex <= k) startindex = k + 1;
          break;
        }
      }
      print("uom" + uom);
      double qty = 0;
      for (j = k; j >= 0; j--) {
        print(actual.elementAt(j));

        if (num.tryParse(actual.elementAt(j)) != null) {
          print("yes");
          qty = double.parse(actual.elementAt(j));
          //startindex = k + 1;
          break;
        }
        if ((actual.elementAt(j)).contains("/")) {
          List fraction = (actual.elementAt(j)).split("/");
          int num = int.parse(fraction[0]);
          int dem = int.parse(fraction[1]);
          qty = (num / dem);
          // if (startindex <= k) k = startindex + 1;
          break;
        }
        print("qty" + qty.toString());
      }
      print("uomac" + uom);
      String ingrName = "";
      if (k >= index) {
        if (j >= index)
          startindex = 0;
        else
          startindex = j + 1;
      }
      else
        startindex = k + 1;

      for (int z = startindex; z <= index; z++) {
        if (actual.elementAt(z) == "of" ||
            actual.elementAt(z) == "fresh" ||
            actual.elementAt(z) == "quality" ||
            actual.elementAt(z) == ")" ||
            actual.elementAt(z) == "or" ||
            actual.elementAt(z) == "x") {
          startindex = z + 1;
          break;
        }
      }
      print("here2");
      for (int z = startindex; z <= index; z++) {
        ingrName += " " + actual.elementAt(z);
      }
      print("this is final" + ingrName + qty.toString() + " " + uom);
      res.add({
        "Name": ingrName,
        "Qty": qty,
        "uom": uom,

      });
    }
    return res;
  }
  List<dynamic> getNutrients(Map<String,dynamic> nut)
  {
    List res=[];
    print(nut);
    List temp=nut.values.toList();
    for(int i=0;i<temp.length;i++)
      {
        res.add({
          "Name": temp.elementAt(i)["label"],
          "Qty": temp.elementAt(i)["quantity"],
          "uom": temp.elementAt(i)["unit"],

        });
      }
    print("res");
    print(res);
    print("res");

    return res;
  }
Future<void> addIngr(List<dynamic> ingr,int qtyfood,int flag)
async {
 print(ingr);
 print("Add"+qtyfood.toString());
 for(int i=0;i<ingr.length;i++)
   {
     //var ingredient=ingr.elementAt(i);
     String line = ingr.elementAt(i)["text"].toString();
     int j = line.indexOf(",");
     String actualIng;
     if (j == -1)
       actualIng = line;
     else
       actualIng = line.substring(0, j);
     print(actualIng);
     List<String> actual = actualIng.split(" ");
     print(actual);
     print(actual.length);
     int index = actual.length - 1;
     print(actual.elementAt(index));
     String uom = "number";
     int k,startindex=0;
     for (k = 0; k < index; k++) {
       print("uomc" + actual.elementAt(k));
       if (actual.elementAt(k).toLowerCase() == "ounce" ||
           actual.elementAt(k).toLowerCase() == "gram" ||
           actual.elementAt(k).toLowerCase() == "pound" ||
           actual.elementAt(k).toLowerCase() == "kilogram" ||
           actual.elementAt(k).toLowerCase() == "pinch" ||
           actual.elementAt(k).toLowerCase() == "liter" ||
           actual.elementAt(k).toLowerCase() == "gallon" ||
           actual.elementAt(k).toLowerCase() == "pint" ||
           actual.elementAt(k).toLowerCase() == "millileter" ||
           actual.elementAt(k).toLowerCase() == "drop" ||
           actual.elementAt(k).toLowerCase() == "cup" ||
           actual.elementAt(k).toLowerCase() == "cups" ||
           actual.elementAt(k).toLowerCase() == "tablespoon" ||
           actual.elementAt(k).toLowerCase() == "tablespoons" ||
           actual.elementAt(k).toLowerCase() == "bunch" ||
           actual.elementAt(k).toLowerCase() == "tbsp" ||
           actual.elementAt(k).toLowerCase() == "tsp" ||
           actual.elementAt(k).toLowerCase() == "g" ||
           actual.elementAt(k).toLowerCase() == "piece" ||
           actual.elementAt(k).toLowerCase() == "pieces" ||
           actual.elementAt(k).toLowerCase() == "oz" ||
           actual.elementAt(k).toLowerCase() == "slice" ||
           actual.elementAt(k).toLowerCase() == "tbsp" ||
           actual.elementAt(k).toLowerCase() == "slices" ||
           actual.elementAt(k).toLowerCase() == "ounce" ||
           actual.elementAt(k).toLowerCase() == "ounces" ||
           actual.elementAt(k).toLowerCase() == "teaspoon") {
         uom = actual.elementAt(k);
         print("uom" + actual.elementAt(k));
         print(k);
         //print(startindex);
         //if (startindex <= k) startindex = k + 1;
         break;
       }
     }
     print("uom"+uom);
     double qty=0;
     for( j=k;j>=0;j--)
       {
         print(actual.elementAt(j));

         if (num.tryParse(actual.elementAt(j)) != null) {
           print("yes");
           qty = double.parse(actual.elementAt(j));
           //startindex = k + 1;
           break;
         }
         if ((actual.elementAt(j)).contains("/")) {
           List fraction = (actual.elementAt(j)).split("/");
           int num = int.parse(fraction[0]);
           int dem = int.parse(fraction[1]);
           qty = (num / dem);
          // if (startindex <= k) k = startindex + 1;
           break;
         }
         print("qty"+qty.toString());
       }
     print("uomac" + uom);
     String ingrName = "";
     if(k>=index)
       {
         if(j>=index)
           startindex=0;
         else
           startindex=j+1;
       }
     else
       startindex=k+1;

     for (int z = startindex; z <= index; z++) {
       if (actual.elementAt(z) == "of" ||
           actual.elementAt(z) == "fresh" ||
           actual.elementAt(z) == "quality" ||
           actual.elementAt(z) == ")" ||
           actual.elementAt(z) == "or" ||
           actual.elementAt(z) == "x") {
         startindex = z + 1;
         break;
       }
     }
     print("here2");
     for (int z = startindex; z <= index; z++) {
       ingrName += " " + actual.elementAt(z);
     }
     print("this is final"+ingrName+qty.toString()+" "+uom);
     print("flag"+flag.toString());
     if(flag==1){
     await user_history.document(uid).collection('Ingr_List').document(ingrName).setData({
       'qty':FieldValue.increment(qty*qtyfood),
       'uom':uom,
        'key':false,
     },SetOptions(merge: true));}
     else
       {
         print("flag");
         DocumentSnapshot ds=await user_history.document(uid).collection('Ingr_List').document(ingrName).get();
        print(ingrName);
        print("name");
        print(ds.get("qty"));
        print(qty);
        print(qtyfood);
        print(ds.get("qty")+(qty*qtyfood));
         if(ds.get("qty")+(qty*qtyfood)<=0) {
           print(ds.get("qty")-(qty*qtyfood));
           print("ingrName");
           print(ingrName);
           user_history.document(uid).collection('Ingr_List')
               .document(ingrName)
               .delete();
         }
         else{
           await user_history.document(uid).collection('Ingr_List').document(ingrName).setData({
             'qty':FieldValue.increment(qty*qtyfood),
             'uom':uom,
             'key':false,
           },SetOptions(merge: true));}
       }
    // print(ingredient);
   }

}
  Future<void> getInfo(String food) async {
    print(food);
    var url =
        "https://api.edamam.com/search?q=$food&app_id=4846916e&app_key=6cf0bbb58cd6ab83f3c56eeccf51cb1a&";
    final response = await http.get(url);
    var responseJson = jsonDecode(response.body.toString());
    print("response");
    print(responseJson);
    var responseHits = (responseJson["hits"][0]["recipe"]["ingredientLines"]);
    var image = (responseJson["hits"][0]["recipe"]["image"]);
    print(responseJson["hits"][0]["recipe"]["ingredients"]);
    print(responseJson["hits"][0]["recipe"]["calories"]);
    print(responseJson["hits"][0]["recipe"]["totalWeight"]);

    return responseJson;
  }
}
