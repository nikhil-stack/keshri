import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keshri/providers/manageData.dart';
import 'package:keshri/widgets/studentDetails.dart';
import 'package:provider/provider.dart';

class PayFee extends StatefulWidget {
  @override
  _PayFeeState createState() => _PayFeeState();
}

class _PayFeeState extends State<PayFee> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ManageData>(
      context,
      listen: false,
    );
    data.getStudents();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay fee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Student Roll No'),
                        readOnly: true,
                        controller: controller,
                      ),
                    ),
                    StreamBuilder(
                        stream: Firestore.instance
                            .collection('students')
                            .orderBy('rollNo')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return CircularProgressIndicator();
                          }
                          return DropdownButton(
                            items: snapshot.data.documents
                                .map<DropdownMenuItem<dynamic>>(
                                  (value) => DropdownMenuItem(
                                    child: Text(value['rollNo'].toString()),
                                    value: value['rollNo'],
                                  ),
                                )
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                controller.text = newValue.toString();
                              });
                              data.getStudentDetails(newValue);
                            },
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              controller.text.isEmpty
                  ? Center(child: Text('Please select a Roll No'))
                  : /*StudentDetails(
                      data.currentStudent.name,
                      data.currentStudent.course,
                      data.currentStudent.feesPaid,
                      data.currentStudent.rollNo,
                      data.currentStudent.section,
                      data.currentStudent.id,
                    ),*/
                  StreamBuilder(
                      stream: Firestore.instance
                          .collection('students')
                          .orderBy('rollNo')
                          .snapshots(),
                      builder: (ctx, snapshot) {
                        if (snapshot.data == null) {
                          return CircularProgressIndicator();
                        }
                        final docs = snapshot
                            .data.documents[int.tryParse(controller.text) - 1];
                        //print(docs);
                        return StudentDetails(
                            docs['name'],
                            docs['course'],
                            docs['feesPaid'],
                            docs['rollNo'],
                            docs['section'],
                            '0');
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
