import 'package:flutter/material.dart';
import 'package:notes/Model/ServiceViewModel.dart';
import 'package:notes/Screens/SignUP.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';


class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),

        ),
        body: ListView(
          children: <Widget>[
            SignIN(),

          ],
        ),
      ),
    );
  }
}

class SignIN extends StatefulWidget {
  @override
  _SignINState createState() => _SignINState();
}

class _SignINState extends State<SignIN> {

  //String userName;
  String email;
  String password;
  //final serviceViewModelProvider=Provider.of<ServiceViewModel>(context,listen:false);


  final _SignINFormKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final serviceViewModelProvider=Provider.of<ServiceViewModel>(context,listen:false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _SignINFormKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Sign In With Google'),
                onPressed: (){
                  print('Signing in with google');
                  serviceViewModelProvider.signInWithGoogle();
                },
              ),
            ),
            Center(
              child: SizedBox(
                height: 2,
                width: double.infinity-30,
              ),
            ),
            Center(child: Text('OR')),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(

                    border: OutlineInputBorder(),
                    labelText: "Email"
                ),
                validator: (value){
                  return validateEmail(value);
                },
                onChanged: (value)=>email=value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: "Password",
                  helperText: " Min 8 Char, atleast one Upper case, one Lower Case, \n one number and one special character ",

                ),
                validator: (value){
                  return validatePassword(value);
                },
                onChanged: (value)=>password=value,

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(

                    child: Text('Sign In'),
                    color: Colors.green,
                    onPressed: (){
                      if(_SignINFormKey.currentState.validate()) {
                        print("validate");
                        serviceViewModelProvider.signInWithEmailAndPassword(email, password);

                        _SignINFormKey.currentState.reset();
                      }
                    },
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Sign Up'),
                    color: Colors.green,
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: ((context)=>SignUp())
                      )
                      );
                    },
                  ),
                )

              ],
            )


          ],
        ),
      ),
    );
  }

}

String  validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String  validatePassword(String value) {
  Pattern pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid password';
  else
    return null;
}