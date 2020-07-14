import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/Model/ServiceViewModel.dart';
import 'package:notes/Screens/Diary.dart';
import 'package:notes/Services/User.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final serviceViewModelProvider=Provider.of<ServiceViewModel>(context,listen:false);
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: serviceViewModelProvider.getSnapShot(Provider.of<User>(context)),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return new Center(child: new CircularProgressIndicator());
              default:
                return new ListView.builder(
                 itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context,int index){
                        return timelineBuilder(context, index, snapshot.data.documents[index],snapshot.data.documents.length);
                  },
                );
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(

          elevation: 1,
          items: const<BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,
              color: Colors.green,),
              title: Text('Setting',
              style: TextStyle(
                color: Colors.green,
              ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('ADD'),


            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline,
              color: Colors.green,
              ),

              title: Text('Sign Out',
                style: TextStyle(
                  color: Colors.green,
                ),)
            ),

          ],
          currentIndex:1,
          onTap:(index){
            if(index==1){
              Navigator.pushNamed(context, '/diary');
            }
            if(index==2){
              serviceViewModelProvider.signOut();
            }

          },
          selectedItemColor: Colors.amber,
          showSelectedLabels: true ,
        ),
      ),
    );
  }
}

Widget timelineBuilder(BuildContext context, int index, DocumentSnapshot documentSnapshot,int length){

  if(index%2==0){
   return Slidable(
     actionPane: SlidableDrawerActionPane(),
     actionExtentRatio: 0.25,

     secondaryActions: getSlidablewidgets(context,documentSnapshot),
     child: TimelineTile(
        rightChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: BoxConstraints(
              minHeight: 100,

            ),

            child: Card(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.00)),
              color: Colors.green,
              child: listTile(context, documentSnapshot)
            ),
          ),
        ),
       alignment: TimelineAlign.manual,
       lineX: 0.1,
       isFirst: index==0?true:false,
       isLast: (index+1)==length?true:false,
      ),
   );
  }else{
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: getSlidablewidgets(context,documentSnapshot),
      child: TimelineTile(
        leftChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: BoxConstraints(
              minHeight: 100,
            ),

            child: Card(
              child: listTile(context, documentSnapshot),
              color: Colors.orange,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
            ),
          ),
        ),
        alignment: TimelineAlign.manual,
        lineX: 0.9,
        isFirst: index==0?true:false,
        isLast: (index+1)==length?true:false,


      ),
    );
  }

}


Widget listTile(BuildContext context,DocumentSnapshot documentSnapshot){
  
  return ListTile(
    title: Text(documentSnapshot['title'],
        style: GoogleFonts.cedarvilleCursive(
          letterSpacing: 3,
          fontSize: 28
        )),
    subtitle: Text(documentSnapshot['diary'],
    style: GoogleFonts.cedarvilleCursive(
      letterSpacing: 3,
      fontSize: 20

    ),),
  );
}

List<Widget> getSlidablewidgets(BuildContext context,DocumentSnapshot documentSnapshot){
  final serviceViewModelProvider=Provider.of<ServiceViewModel>(context,listen:false);

  return [
    IconSlideAction(
      caption: 'Update',
      color: Colors.greenAccent,
      icon: Icons.update,
      onTap: () => print('More'),
    ),
    IconSlideAction(
      caption: 'Delete',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () {
        serviceViewModelProvider.deleteDocument(documentSnapshot);
      },
    ),
  ];

}