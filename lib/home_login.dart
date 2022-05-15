// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_corner/function/function.dart';
import 'package:students_corner/function/model_student.dart';
import 'package:students_corner/function/profile_student.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _batchController = TextEditingController();

  final _domainController = TextEditingController();

  var _image;

  @override
  Widget build(BuildContext context) {
    getStudent();
    return Container(
      decoration: const BoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('SPS'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 2, 148, 22),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Name',
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Age',
                    filled: true),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _batchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Batch',
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _domainController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Domain',
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
            ),
            const SizedBox(
              height: 0,
            ),
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  icon: const Icon(Icons.upload_file_rounded),
                  label: const Text('Upload Image'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 2, 148, 22),
                  ),
                ),

                //ADD
                ElevatedButton.icon(
                  onPressed: () {
                    onAddStudentButtonClicked(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Student'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 2, 148, 22),
                  ),
                ),

                //VIEW
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentList(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.remove_red_eye),
                  label: const Text('View List'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 2, 148, 22),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//EMPTY CHECK
  Future<void> onAddStudentButtonClicked(context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _batch = _batchController.text.trim();
    final _domain = _domainController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _batch.isEmpty || _domain.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'please enter the inputs',
        textAlign: TextAlign.center,
      )));
      // return;
    } else {
      final studentDetails = StudentModel(
        name: _name,
        age: _age,
        batch: _batch,
        domain: _domain,
        image: _image,
      );
      addStudent(studentDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'detail added',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  // DIALOGUE BOX

  showAlertDialog(BuildContext context) {
    Widget galleryButton = IconButton(
      icon: const Icon(
        Icons.image,
        size: 30,
      ),
      onPressed: () async {
        var image = await getFromGallery();
        setState(() {
          _image = image;
        });
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Choose"),
      titleTextStyle: const TextStyle(
        color: Color.fromARGB(255, 2, 148, 22),
      ),
      // content: const Text(""),
      actions: [
        galleryButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
