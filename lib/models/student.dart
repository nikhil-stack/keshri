import 'package:flutter/foundation.dart';

class Student {
  String name;
  int rollNo;
  String section;
  String course;
  String id;
  int feesPaid;
  Student({
    @required this.name,
    @required this.rollNo,
    @required this.section,
    @required this.course,
    this.id,
    this.feesPaid,
  });
}
