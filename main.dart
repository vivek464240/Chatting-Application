

// ignore_for_file: unused_import

import 'package:chatapp/helper/helper_function.dart';
import 'package:chatapp/pages/auth/login_page.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
    // ignore: unnecessary_const
    options: const FirebaseOptions(
      apiKey: 'Constants.apiKey' ,
      appId: 'Constants.appId',
      messagingSenderId: 'Constants.messagingSenderId' ,
      projectId:  'Constants.projectId' ));
  }
     else{
    await Firebase.initializeApp();
  }
     runApp( const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp ({Key? key}): super(key: key);

  // ignore: annotate_overrides
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
    // ignore: prefer_final_fields
    bool _isSignedIn =  false;
     // ignore: annotate_overrides
     void initState(){
      super.initState();
      getUserLoggedInStatus();
     }

     getUserLoggedInStatus() async{
      await HelperFunctions.getUserLoggedInStatus().then((value){
        if(value != null){
          setState((){
            _isSignedIn = value;
          });

        }
      });

      
     }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
      scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false ,
      home: _isSignedIn ? const HomePage() : const LoginPage(),
    );
  }
}



