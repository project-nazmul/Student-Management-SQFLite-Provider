import 'package:flutter/material.dart';
import 'package:sqflite_crud/database/db_student_manager.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_crud/model/student.dart';

updateStudent({required BuildContext context,required Student student}){
  final provider = Provider.of<DbStudentManager>(context,listen: false);
  provider.updateStudent(student);
}