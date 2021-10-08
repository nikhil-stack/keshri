import 'package:flutter/material.dart';
import 'package:keshri/providers/manageData.dart';
import 'package:keshri/widgets/category_item.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ManageData>(context).updateCoursesFee();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          CategoryItem('Add Student', Colors.red, '/add-student'),
          SizedBox(
            height: 50,
          ),
          CategoryItem('Pay fee', Colors.blue, '/pay-fee'),
          SizedBox(
            height: 50,
          ),
          CategoryItem('Fees structure', Colors.green, '/fees-structure'),
        ],
      ),
    );
  }
}
