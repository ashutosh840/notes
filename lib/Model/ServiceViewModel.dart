
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes/Services/AuthService.dart';
import 'package:notes/Services/DatabaseService.dart';
import 'package:notes/Services/User.dart';

class ServiceViewModel extends ChangeNotifier {




  final AuthService _authService=AuthService();
  final DatabaseService _databaseService=DatabaseService();
  String _uid;

 /* ServiceViewModel(){
    _databaseService.configure();
  }*/



  void signInWithEmailAndPassword(String email,String password) async {
     await _authService.signInWithEmailAndPassword(email, password);

   }

  void registerInWithEmailAndPassword(String email,String password) async {
     await _authService.registerWithEmailAndPassword(email, password);
  }

  void signInWithGoogle()async {
   await _authService.signInWithGoogle();
    print('Sign In With Google');
   }

  void signOut(){
     _authService.signOut();
     _uid=null;
   }

  /* void setUid() async{
     _uid=await _authService.getCurrentUser();

   }*/

   void setData(String title, String diary, DateTime dateTime) async{
     await _authService.getCurrentUser().then((value) async {
       return await _databaseService.setNewData(value, title, diary, dateTime);
     });

   }

   Stream<QuerySnapshot> getSnapShot(User user)   {
     return _databaseService.diarySnapshot(user);
   }

   void deleteDocument(DocumentSnapshot documentSnapshot) async{
     await _authService.getCurrentUser().then((value) async{

       await _databaseService.deleteCurrentDocument(User(value.uid), documentSnapshot);

     });

   }


}