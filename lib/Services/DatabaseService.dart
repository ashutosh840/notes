import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'User.dart';


class DatabaseService{


  final Firestore _firestore=Firestore.instance;




 /* Future<void> configure() async{
    final FirebaseApp app=await FirebaseApp.configure(name:'notes',
      options: FirebaseOptions(
          googleAppID: '1:1051484666895:android:7e879575351f8463b2f77a',
          projectID: 'notes-e2864',
          gcmSenderID:'1051484666895',
          apiKey: 'AIzaSyBrCie0qxxwn0KwSLJ1wwTxnVZ7nLz-QkY'

      ),

    );
    _firestore = Firestore(app: app);
  }*/



  Future setNewData(FirebaseUser user,String title,String diary,DateTime dateTime) async{

    await _firestore.collection(user.uid).document().setData({

      'title':title,
      'diary':diary,
      'dateTime':dateTime.toString(),
      'uid':user.uid
    });
  }

  Stream<QuerySnapshot>  diarySnapshot(User user){

    return _firestore
        .collection(user.uid)

        .where('uid', isEqualTo:user.uid)
        .snapshots();

  }

  Future deleteCurrentDocument(User user,DocumentSnapshot documentSnapshot)  async{

    await _firestore
        .collection(user.uid)
        .document(documentSnapshot.documentID).delete();

  }

}