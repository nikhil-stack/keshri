import 'package:flutter/material.dart';
import 'package:keshri/providers/manageData.dart';
import 'package:keshri/screens/add_student.dart';
import 'package:keshri/screens/dashboard.dart';
import 'package:keshri/screens/fees_structure.dart';
import 'package:keshri/screens/pay_fee.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ManageData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Keshri app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DashBoard(),
        routes: {
          '/add-student': (_) => AddStudent(),
          '/pay-fee': (_) => PayFee(),
          '/fees-structure': (_) => FeesStructure(),
        },
      ),
    );
  }
}
