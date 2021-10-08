import 'package:flutter/cupertino.dart';
import 'package:keshri/models/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageData with ChangeNotifier {
  List<Student> _students = [];
  int _rollNo = 1;
  List<int> _studentRollNo = [];
  Student _currentStudent =
      Student(name: '', rollNo: 0, section: '', course: '');
  Map<String, int> _coursesFee = {};

  Map<String, int> get coursesFee {
    return {..._coursesFee};
  }

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

  Future<void> updateCoursesFee() async {
    var querySnapshot =
        await Firestore.instance.collection('fees').getDocuments();
    var documents = querySnapshot.documents;
    documents.forEach((element) {
      _coursesFee.putIfAbsent(element['course'], () => element['fees']);
    });
    //print(_coursesFee);
    notifyListeners();
  }

  Future<void> fetchAndSetProducts() async {
    try {
      List<Student> loadedStudents = [];

      var querySnapshot =
          await Firestore.instance.collection('students').getDocuments();
      var documents = querySnapshot.documents;
      documents.forEach((element) {
        loadedStudents.add(Student(
            name: element['name'],
            rollNo: element['rollNo'],
            section: element['section'],
            course: element['course'],
            feesPaid: 0));
      });
      _students = loadedStudents;
      print(_students);
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addStudent(Student student) async {
    try {
      _rollNo = _students.length + 1;

      Firestore.instance
          .collection('students')
          .document(_rollNo.toString())
          .setData({
        'name': student.name,
        'rollNo': _rollNo,
        'section': student.section,
        'course': student.course,
        'feesPaid': 0,
      });
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> getStudents() async {
    List<int> loadedRollNo = [];
    var querySnapshot =
        await Firestore.instance.collection('students').getDocuments();
    var documents = querySnapshot.documents;
    documents.forEach(
      (element) {
        loadedRollNo.add(element['rollNo']);
      },
    );
    _studentRollNo = loadedRollNo;

    notifyListeners();
  }

  Future<void> getStudentDetails(int rollNo) async {
    var responseDataa =
        await Firestore.instance.collection('students').getDocuments();
    var documents = responseDataa.documents;
    documents.forEach((value) {
      if (value['rollNo'] == rollNo) {
        _currentStudent = Student(
          name: value['name'],
          rollNo: rollNo,
          section: value['section'],
          course: value['course'],
          feesPaid: value['feesPaid'],
        );
      }
    });
    notifyListeners();
  }

  Future<void> payFees(Student newStudent, String id) async {
    var collection = Firestore.instance.collection('students');
    collection.document(newStudent.rollNo.toString()).updateData({
      'feesPaid': newStudent.feesPaid,
    });
    notifyListeners();
  }
}
