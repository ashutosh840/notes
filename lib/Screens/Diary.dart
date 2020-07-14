import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/Model/ServiceViewModel.dart';
import 'package:notes/Services/User.dart';
import 'package:provider/provider.dart';


class Diary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(

        appBar: AppBar(
         elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
            color: Colors.black,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: DiaryForm(),
      ),
    );
  }
}

class DiaryForm extends StatefulWidget {
  @override
  _DiaryFormState createState() => _DiaryFormState();
}

class _DiaryFormState extends State<DiaryForm> {

  final _diaryKey=GlobalKey<FormState>();
  String title;
  String diary;



  @override
  Widget build(BuildContext context) {
    final serviceViewModelProvider=Provider.of<ServiceViewModel>(context,listen:false);
    return Form(
      key: _diaryKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                    maxLength: 50,
                    validator: (value){
                    if(value.length<=3){
                      return 'Title should be atleast three character long';
                    }
                     return null;
                    },
                    onChanged: (value){
                    setState(() {
                      title=value;
                    });

                    },
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 800,
                      maxLengthEnforced: true,
                      minLines: 13,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tell me what happened ...',
                        helperText: 'Try to follow in character length limit'
                      ),
                      validator: (value){
                        if(value.length<=20){
                          return 'Atleast write 20 words ';
                        }
                        return null;
                      },
                      onChanged: (value){
                        setState(() {
                          diary=value;
                        });
                      },
                    ),

                  ),
                ),
                FlatButton(
                  child:Text('Validate'),
                  onPressed: (){
                    print(diary);
                    if(_diaryKey.currentState.validate()){
                      print('Validate');
                      serviceViewModelProvider.setData(title, diary, DateTime.now());
                      _diaryKey.currentState.reset();
                      Navigator.of(context,rootNavigator: true).pop(context);

                     // if(Provider.of<User>(context,listen: false) != null){print(Provider.of<User>(context,listen: false).uid);}

                     // _diaryKey.currentState.reset();
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
