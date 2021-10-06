import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:keshri/models/student.dart';
import 'package:http/http.dart' as http;

class ManageData with ChangeNotifier {
  List<Student> _students = [];
  int _rollNo = 1;
  List<int> _studentRollNo = [];
  Student _currentStudent =
      Student(name: '', rollNo: 0, section: '', course: '');

  List<Student> get students {
    return [..._students];
  }

  int get rollNo {
    return _rollNo;
  }

  List<int> get studentRollNo {
    return [..._studentRollNo];
  }

  Student get currentStudent {
    return _currentStudent;
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://keshri-d405a-default-rtdb.firebaseio.com/students.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Student> loadedStudents = [];
      extractedData.forEach((key, value) {
        loadedStudents.add(
          Student(
              name: value['Name'],
              rollNo: value['RollNo'],
              section: value['Section'],
              course: value['Course'],
              id: key,
              feesPaid: 0),
        );
      });
      _students = loadedStudents;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addStudent(Student student) async {
    final url = Uri.parse(
        'https://keshri-d405a-default-rtdb.firebaseio.com/students.json');
    try {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //int currentRollNo = (prefs.getInt('rollNo') ?? 0) + 1;
      //_rollNo = currentRollNo;
      _rollNo = _students.length + 1;
      final response = await http.post(
        url,
        body: json.encode(
          {
            'RollNo': _rollNo,
            'Name': student.name,
            'Course': student.course,
            'Section': student.section,
            'FeesPaid': 0,
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(json.decode(response.body));
      /*_students.add(
        Student(
          name: student.name,
          section: student.section,
          course: student.course,
          rollNo: student.rollNo,
          id: responseData['name'],
          feesPaid: 0,
        ),
      );*/
      //await prefs.setInt('rollNo', _students.length);

      print(responseData['name']);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> getStudents() async {
    final url = Uri.parse(
        'https://keshri-d405a-default-rtdb.firebaseio.com/students.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<int> loadedRollNo = [];
    extractedData.forEach((key, value) {
      loadedRollNo.add(value['RollNo']);
    });
    _studentRollNo = loadedRollNo;
    notifyListeners();
  }

  Future<void> getStudentDetails(int rollNo) async {
    final url = Uri.parse(
        'https://keshri-d405a-default-rtdb.firebaseio.com/students.json');
    final response = await http.get(url);
    final responseData =
        await json.decode(response.body) as Map<String, dynamic>;
    //print(responseData);
    responseData.forEach((key, value) {
      if (value['RollNo'] == rollNo) {
        /*currentStudent.name = value['Name'];
        currentStudent.course = value['Course'];
        currentStudent.rollNo = value['RollNo'];
        currentStudent.section = value['Section'];*/
        //print(value['Name']);
        _currentStudent = Student(
            name: value['Name'],
            rollNo: rollNo,
            section: value['Section'],
            course: value['Course'],
            feesPaid: value['FeesPaid'],
            id: key);
      }
    });

    notifyListeners();
  }

  Future<void> payFees(Student newStudent, String id) async {
    final url = Uri.parse(
        'https://keshri-d405a-default-rtdb.firebaseio.com/students/$id.json');
    await http.patch(
      url,
      body: json.encode(
        {
          'Name': newStudent.name,
          'RollNo': newStudent.rollNo,
          'Course': newStudent.course,
          'Section': newStudent.section,
          'FeesPaid': newStudent.feesPaid,
        },
      ),
    );
    notifyListeners();
  }
}
