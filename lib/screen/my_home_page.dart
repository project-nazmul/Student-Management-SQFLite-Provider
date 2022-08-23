import 'package:flutter/material.dart';
import 'package:sqflite_crud/database/db_student_manager.dart';
import 'package:sqflite_crud/model/student.dart';
import 'package:sqflite_crud/widget/add_student.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_crud/widget/deleteStudent.dart';
import 'package:sqflite_crud/widget/updateStudent.dart';

class MyHomePage extends StatelessWidget {

  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  late List<Student> students;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbStudentManager>(context,listen: true);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Name'),
                    controller: _nameController,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Course'),
                    controller: _courseController,
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      addStudent(context: context,name: _nameController.text, course: _courseController.text);
                      _nameController.clear();
                      _courseController.clear();
                    },
                  ),
                  FutureBuilder(
                    future: provider.getStudentList(),
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.hasData) {
                        students = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: students == null ?0 : students.length,
                          itemBuilder: (BuildContext context, int index) {
                            Student student = students[index];
                            return Card(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: width*0.6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Name: ${student.name}',style: TextStyle(fontSize: 15),),
                                        Text('Course: ${student.course}', style: TextStyle(fontSize: 15, color: Colors.black54),),
                                      ],
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: (){
                                    _nameController.text=student.name;
                                    _courseController.text=student.course;
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Text('Update Student'),
                                        content: Column(
                                          children: [
                                            TextFormField(
                                              decoration: new InputDecoration(labelText: 'Name'),
                                              controller: _nameController,
                                            ),
                                            TextFormField(
                                              decoration: new InputDecoration(labelText: 'Course'),
                                              controller: _courseController,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            child: const Text('Submit'),
                                            onPressed: () {
                                              student.name=_nameController.text;
                                              student.course=_courseController.text;
                                              updateStudent(context: context, student: student);
                                              _nameController.clear();
                                              _courseController.clear();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },);
                                    },
                                    icon: Icon(Icons.edit, color: Colors.blueAccent,),
                                  ),
                                  IconButton(onPressed: (){
                                    deleteStudent(context: context, id: student.id!.toInt());
                                  }, icon: Icon(Icons.delete, color: Colors.red,),)

                                ],
                              ),
                            );
                          },

                        );
                      }
                      return new CircularProgressIndicator();
                    },
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
