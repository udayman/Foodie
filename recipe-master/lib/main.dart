import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/settings.dart';
import 'package:recipe/test.dart';
import 'package:recipe/user.dart';
import 'package:recipe/youTube.dart';

import 'firstscreen.dart';
import 'foodsearch.dart';
import 'ingredientCart.dart';
import 'itemDetail.dart';
import 'itemList.dart';
import 'login_page.dart';
import 'notifier.dart';
/*import 'package:flutter_app/itemList.dart';
import 'package:flutter_app/foodSearch.dart';
import 'package:flutter_app/ingredientCart.dart';
import 'package:flutter_app/itemDetail.dart';
import 'package:flutter_app/youtube.dart';
import 'package:provider/provider.dart';
import 'settings.dart';

import 'firstscreen.dart';
import 'user_profile.dart';
import 'login_page.dart';
import 'notifier.dart';*/

//void main() => runApp(MyApp());
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//void main()=>runApp(ItemDetail("tea"));

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch(settings.name)
  {
    case '/':
      return MaterialPageRoute(builder: (context)=>LoginPage());
    case 'first':
    //var loginArgument = settings.arguments;
      return MaterialPageRoute(builder: (context)=>MainMenu());
    case 'foodSearch':
      var foodName = settings.arguments;
      return MaterialPageRoute(builder: (context)=>ExamplePage(value: foodName,));
    case 'cart':
      return MaterialPageRoute(builder: (context)=>itemList());
    case 'ingredientList':
      return MaterialPageRoute(builder: (context)=>ingredientList());
    case 'youTube':
      var item=settings.arguments;
      print(item);
      return MaterialPageRoute(builder: (context)=>Youtube(item));
    case 'itemDetail':
      var foodName = settings.arguments;
      print(foodName);
      return MaterialPageRoute(builder: (context)=>ItemDetail(foodName));
    case 'test':
      var foodName = settings.arguments;
      print(foodName);
      return MaterialPageRoute(builder: (context)=>Test(foodName));
    case 'settings':
      return MaterialPageRoute(builder: (context)=>Settings());
    case 'user':
      return MaterialPageRoute(builder: (context)=>UserProfile());
    default:
      return MaterialPageRoute(builder: (context)=>LoginPage());
  }
}
class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
        create: (context) => Info(),
        child:MaterialApp(
          title: 'Flutter Login',
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,
          ),
          initialRoute: '/',
          onGenerateRoute: generateRoute,

        )
    );

  }
}