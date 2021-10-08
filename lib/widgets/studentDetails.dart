import 'package:flutter/material.dart';
import 'package:keshri/models/student.dart';
import 'package:keshri/providers/manageData.dart';
import 'package:provider/provider.dart';

class StudentDetails extends StatefulWidget {
  //const StudentDetails({ Key? key }) : super(key: key);
  final String studentName;
  final String studentCourse;
  final int studentFeesPaid;
  final int studentRollNo;
  final String studentSection;
  final String studentId;
  StudentDetails(
    this.studentName,
    this.studentCourse,
    this.studentFeesPaid,
    this.studentRollNo,
    this.studentSection,
    this.studentId,
  );

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final TextEditingController controller2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ManageData>(context);
    int feeDifference =
        (data.coursesFee[widget.studentCourse] - widget.studentFeesPaid);
    int feesPaid = widget.studentFeesPaid;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Student Name: '),
            Text(widget.studentName),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Student Course: '),
            Text(widget.studentCourse),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Student Fees Paid: '),
            Text(feesPaid.toString()),
          ],
        ),
        feeDifference >= 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Student Fees Remaining: '),
                  Text(feeDifference.toString())
                ],
              )
            : Row(
                children: [
                  Text('Student fees in advance: '),
                  Text((-1 * feeDifference).toString()),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller2,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: 'Amount you want to pay.'),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  feesPaid =
                      widget.studentFeesPaid + int.tryParse(controller2.text);
                  feeDifference = (data.coursesFee[widget.studentCourse] - feesPaid);
                  controller2.clear();
                });

                data.payFees(
                  Student(
                    name: widget.studentName,
                    rollNo: widget.studentRollNo,
                    section: widget.studentSection,
                    course: widget.studentCourse,
                    feesPaid: feesPaid,
                  ),
                  widget.studentId,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Fees Paid Successfully'),
                    duration: Duration(seconds: 3),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Pay'),
            ),
          ],
        )
      ],
    );
  }
}
