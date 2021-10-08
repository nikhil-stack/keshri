import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeesStructure extends StatelessWidget {
  //const FeesStructure({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<ListTile>
    //fees = CoursesFee.entries.map((e) => ListTile(leading: Text(e.key),trailing: Text(e.value.toString()),)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees Structure'),
      ),
      //body: ListView(children: fees),
      body: StreamBuilder(
        stream: Firestore.instance.collection('fees').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return CircularProgressIndicator();
          }
          final docs = snapshot.data.documents;
          return ListView.builder(
            itemBuilder: (ctx, index) => ListTile(
              leading: Text(docs[index]['course']),
              trailing: Text(docs[index]['fees'].toString()),
            ),
            itemCount: docs.length,
          );
        },
      ),
    );
  }
}
