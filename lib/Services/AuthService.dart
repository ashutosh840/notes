import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/Exception/Exception.dart';
import 'User.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  //To get User from Firebase User
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //Sign In with Email and Password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }on PlatformException catch(e){

      print(e.message);
      print(e.code);
      print(e.details);

    }
    catch (error) {
      print(error.toString());
      return User(null);
    }
  }

  // register with email and password
  Future<User> registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid

      // await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return User(null);
    }
  }

  // sign out
  void signOut() async {
    try {
       await _auth.signOut();
       await _googleSignIn.signOut();
    }on PlatformException catch(e){

    print(e.message);
    print(e.code);
    print(e.details);

    } catch (error) {
      print(error);
    }
  }
  
  Future<FirebaseUser> getCurrentUser()async{
    return await _auth.currentUser().then((value) {

      return value;
    });
  }


  Future<User> signInWithGoogle() async{
    try {
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user ;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return User(null);
    }
  }


}