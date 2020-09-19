

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = await _auth.currentUser;

  assert(user.uid == currentUser.uid);
  print(user.photoUrl);
  print(user.displayName);
  //await DatabaseService(uid:user.uid).updateUser("h");
  //await(user.get().getName());
  print(credential);
  print("success");
  print(user.uid);
  print(user);
  print(currentUser);
  print(currentUser.uid);
  //print(user.name);

  //return snapshot;
  return user;

}

Future<void> signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out");
}