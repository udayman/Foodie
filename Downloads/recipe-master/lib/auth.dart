import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
   String uid;
   //print("ns"+uid);
  DatabaseService({this.uid});

  // ignore: non_constant_identifier_names
  final CollectionReference user_history=Firestore.instance.collection("User_History");

  //DatabaseService(this.uid);
   Future addData(List name) async
   {
     //updateUser(uid1)
     print("uid");
     print(this.uid);
     print("hoe");

     //return await user_history.document(uid).updateData({"name":FieldValue.arrayUnion(name)});
   }
  Future updateUser(String uid1)
  async {
    print("uid final"+uid);
    this.uid=uid1;
    print(this.uid+"public");
    addData(['d','df']);
    /*return await user_history.document(uid).setData({

    /* 'name':{
       "first":name,
       "last":"sd",
     }*/
    });*/

  }

  Stream<QuerySnapshot> get userData{
    return user_history.snapshots();
  }
}