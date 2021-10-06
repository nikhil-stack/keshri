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
    );
    data.getStudents();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay fee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Student Roll No'),
                    readOnly: true,
                    controller: controller,
                  ),
                ),
                DropdownButton(
                  items: data.studentRollNo
                      .map(
                        (value) => DropdownMenuItem(
                          child: Text(value.toString()),
                          value: value,
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      controller.text = newValue.toString();
                    });
                    data.getStudentDetails(newValue);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            controller.text.isEmpty || data.currentStudent.name.isEmpty 
                ? Center(child: Text('Please select a Roll No'))
                : StudentDetails(
                    data.currentStudent.name,
                    data.currentStudent.course,
                    data.currentStudent.feesPaid,
                    data.currentStudent.rollNo,
                    data.currentStudent.section,
                    data.currentStudent.id,
                  ),
                
          ],
        ),
      ),
    );
  }
}
