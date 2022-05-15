import 'dart:io';

import 'package:flutter/material.dart';
import 'package:students_corner/function/function.dart';
import 'function/model_student.dart';

class StudentProfile extends StatelessWidget {
  // Widget styldiv = const Divider(
  //   color: Color.fromARGB(255, 224, 59, 18),
  //   thickness: 2,
  //   indent: 20,
  //   endIndent: 20,
  // );
  final index;
  const StudentProfile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
          final data = studentlist[this.index];
          return Scaffold(
            appBar: AppBar(
              backgroundColor:Color.fromARGB(255, 2, 148, 22),
              title: const Text('Student Details'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Center(
                child: Card(
                  child: Container(
                   
                    height: 600,width: 300,
                    color: Color.fromARGB(255, 234, 241, 234),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Container(

                          child: CircleAvatar(
                            backgroundImage: FileImage(File(data.image!)),
                            radius: 100,
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            // styldiv,
                            display("Name:", data.name.toUpperCase()),
                            //styldiv,
                            display("Age:", data.age),
                            //styldiv,
                            display("Batch:", data.batch.toUpperCase()),
                            // styldiv,
                            display("Domain:", data.domain),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget display(field, data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            field,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            data,
            style: const TextStyle(fontSize: 25),
          )
        ],
      ),
    );
  }
}
