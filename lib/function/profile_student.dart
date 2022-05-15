import 'dart:io';
import 'package:flutter/material.dart';
import 'package:students_corner/details_student.dart';
import 'package:students_corner/function/function.dart';
import 'package:students_corner/function/update_student_dialogue.dart';
import 'package:students_corner/search_student.dart';

import 'model_student.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 2, 148, 22),
          title: const Text('Students List'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearch());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        backgroundColor: Colors.white,
        body: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext ctx, List<StudentModel> studentlist,
              Widget? child) {
            return ListView.separated(
              itemBuilder: ((context, index) {
                final data = studentlist[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => StudentProfile(
                              index: index,
                            )),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(data.image)),
                  ),
                  title: Text(
                    data.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                  subtitle: Text(data.batch),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          updateStudent(context, index);
                        },
                        icon: const Icon(Icons.edit),
                        color: Color.fromARGB(255, 14, 159, 199),
                      ),
                      IconButton(
                        onPressed: () {
                          showAlertDialog(context, index);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              }),
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: studentlist.length,
            );
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        deleteStudent(index);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete!"),
      titleTextStyle:
          const TextStyle(color: Colors.deepOrangeAccent, fontSize: 20),
      content: const Text("Are You Sure?"),
      contentTextStyle:
          const TextStyle(color: Colors.deepOrangeAccent, fontSize: 15),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
