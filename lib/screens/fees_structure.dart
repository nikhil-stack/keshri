import 'package:flutter/material.dart';
import 'package:keshri/models/courses_fee.dart';

class FeesStructure extends StatelessWidget {
  //const FeesStructure({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ListTile> 
    fees = CoursesFee.entries.map((e) => ListTile(leading: Text(e.key),trailing: Text(e.value.toString()),)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees Structure'),
      ),
      body: ListView(children: fees),
    );
  }
}
