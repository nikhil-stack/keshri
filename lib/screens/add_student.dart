import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keshri/models/student.dart';
import 'package:keshri/providers/manageData.dart';
import 'package:provider/provider.dart';

class AddStudent extends StatefulWidget {
  //const AddStudent({ Key? key }) : super(key: key);
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  var courseController = TextEditingController();
  var sectionController = TextEditingController();
  var nameController = TextEditingController();
  Key key = GlobalKey<FormState>();
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<ManageData>(context).fetchAndSetProducts();
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ManageData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Form(
              key: key,
              child: Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Section'),
                            controller: sectionController,
                            readOnly: true,
                          ),
                        ),
                        DropdownButton(
                          items: <String>[
                            'A',
                            'B',
                          ]
                              .map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              sectionController.text = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Course'),
                            controller: courseController,
                            readOnly: true,
                          ),
                        ),
                        DropdownButton(
                          items: <String>[
                            'B.Tech',
                            'M.Tech.',
                            'B.Sc',
                            'M.Sc.',
                            'BCA'
                          ]
                              .map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              courseController.text = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (nameController.text.trim().isNotEmpty &&
                        courseController.text.isNotEmpty &&
                        sectionController.text.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () {
                              data.addStudent(
                                Student(
                                    name: nameController.text,
                                    rollNo: data.rollNo,
                                    section: sectionController.text,
                                    course: courseController.text),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Student added Successfully!'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
