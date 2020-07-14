
import 'package:flutter/material.dart';
import 'package:notes/Model/ServiceViewModel.dart';
import 'package:notes/Screens/signIN.dart';
import 'package:provider/provider.dart';



class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: ListView(
          children: <Widget>[
            SignUP(),
          ],
        )
      ),
    );
  }
}

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final _SignUPFormKey = GlobalKey<FormState>();
  String name;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    final serviceViewModelProvider=Provider.of<ServiceViewModel>(context,listen:false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(

        key: _SignUPFormKey,
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
                keyboardType: TextInputType.text,

                decoration: InputDecoration(


                    border: OutlineInputBorder(),
                    labelText: "Enter Your Name"
                ),
                validator: (value){
                  if(value.length<=3){
                    return 'Please Enter some Text';
                  }
                  return null;
                },
                onChanged: (value){
                  setState(() {
                    name=value;
                  });
                },

              ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,

                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  labelText: "Confirm Password",
                  helperText: " make sure this matches with password ",


                ),
                validator: (value){
                  if(value!=password){
                    password=null;
                    return 'Password did not match';
                  }
                  return null;
                  },
               // onChanged: (value)=>password=value,

              ),
            ),

            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Sign Up'),
                    color: Colors.green,
                    onPressed: (){
                      if(_SignUPFormKey.currentState.validate()) {
                        print("validate");
                        serviceViewModelProvider.registerInWithEmailAndPassword(email, password);
                        _SignUPFormKey.currentState.reset();


                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Sign In'),
                    color: Colors.green,
                    onPressed: (){
                      Navigator.of(context,rootNavigator: true).pop(context);

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