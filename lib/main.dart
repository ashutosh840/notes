import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/Model/ServiceViewModel.dart';
import 'package:notes/Screens/Diary.dart';
import 'package:notes/Screens/Home.dart';
import 'package:notes/Screens/SignUP.dart';
import 'package:notes/Screens/signIN.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Services/AuthService.dart';
import 'Services/User.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  /*final FirebaseApp app=await FirebaseApp.configure(name:'notes',
      options: FirebaseOptions(
        googleAppID: '1:1051484666895:android:7e879575351f8463b2f77a',
        projectID: 'notes-e2864',
        gcmSenderID:'1051484666895',
        apiKey: 'AIzaSyBrCie0qxxwn0KwSLJ1wwTxnVZ7nLz-QkY'

      ),

  );*/
 // final Firestore firestore = Firestore(app: app);
  runApp(

      MultiProvider(
        providers: [
          StreamProvider<User>.value(value: AuthService().user),
          ChangeNotifierProvider(create: (_)=>ServiceViewModel(),)
        ],
        child: MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     initialRoute: '/wrapper',
     routes: {
       '/wrapper':(context)=>Wrapper(),
       '/signIn' :(context)=>SignIn(),
       '/signUp' :(context)=>SignUp(),
       '/diary'  :(context)=>Diary(),
       '/home'   :(context)=>Home()
     },
     home: Wrapper(),
   );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(Provider.of<User>(context)!=null){
      return Home();
    }else{
      return SignIn();
    }
  }
}

