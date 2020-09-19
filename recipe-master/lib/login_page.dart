import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'notifier.dart';
import 'auth.dart';
import 'notifier.dart';
import 'sign_in.dart';

//import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class FirstScreen extends StatelessWidget {
  final String argument;
  const FirstScreen({Key key, this.argument}) : super(key: key);

  Widget build(BuildContext context) {
    //  Provider.of<Info>(context).getID(argument);

    print(argument);

    return Scaffold(
        body:  OutlineButton(
            splashColor: Colors.grey,
            child: Text("Sign out"),

            onPressed: () {
              signOutGoogle().then((e) {
                Navigator.pop(context);
                /*Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
              ),
            );*/
              });
            }
        )
    );
  }
}



class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: new Text.rich(
                  TextSpan(
                    children: <TextSpan>[

                      TextSpan(text: 'The Foodie App', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,)),
                    ],
                  ),
                ),
              ),
              new Image(
                  image: new AssetImage("assets/foodiediff.JPG"),
                  height: 300,
                  width: 300
              ),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
      /* body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),*/
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        /*final user= signInWithGoogle().whenComplete(() {
          //final user = snapshot;
         //print(user);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FirstScreen();
              },
            ),
          );
        });*/
        var username;
        signInWithGoogle().then((user) async {
          username = user;
          var id= user.uid;
          print("id"+id);
          print(id.toString());
          var name=user.displayName;
          var photo=user.photoUrl;

          print(user);
          print("hey");
          await Provider.of<Info>(context).getDetails(id,name,photo);
          Navigator.pushNamed(context, 'first');
         // await Provider.of<Info>(context).getID(user);
          print(user);
          //  var id=Provider.of<Info>(context).id;
          //await Provider.of<Info>(context).getFood();
          //print(Provider.of<Info>(context).foodList);
          /*Navigator.of(context).push(
           MaterialPageRoute(
             builder: (context) {
               return FirstScreen();
             },
           ),
         );*/
          print("up");
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
