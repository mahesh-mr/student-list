import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_corner/function/function.dart';
import 'package:students_corner/function/model_student.dart';

final _updateNameController = TextEditingController();
final _updateAgeController = TextEditingController();
final _updateBatchController = TextEditingController();
final _updateDomainController = TextEditingController();
ImagePicker imagePicker = ImagePicker();
var image;
Future<void> updateStudent(BuildContext context, int index) async {
  _updateNameController.text = studentListNotifier.value[index].name;
  _updateAgeController.text = studentListNotifier.value[index].age;
  _updateBatchController.text = studentListNotifier.value[index].batch;
  _updateDomainController.text = studentListNotifier.value[index].domain;

  return showDialog(
    context: context,
    builder: (context) {
      return Card(
        child: AlertDialog(
          title: const Text('Update Student Details'),
          titleTextStyle:
              const TextStyle(color: Color.fromARGB(255, 2, 148, 22),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {},
                controller: _updateNameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                onChanged: (value) {},
                controller: _updateAgeController,
                decoration: const InputDecoration(hintText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                onChanged: (value) {},
                controller: _updateBatchController,
                decoration: const InputDecoration(hintText: 'Batch'),
              ),
              TextField(
                onChanged: (value) {},
                controller: _updateDomainController,
                decoration: const InputDecoration(hintText: 'Domain'),
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      XFile? img = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      
                        image = img?.path;
            
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Upload Image'),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 2, 148, 22),),
                  ),
                  const SizedBox(height: 10,width: 5,),
                  ElevatedButton.icon(
                    onPressed: () {
                      onUpdateButtonClicked(index, context);
                      Navigator.of(context).pop(
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('details updated',textAlign: TextAlign.center,style: TextStyle(color: Color.fromARGB(255, 2, 148, 22)),))),
                        
                      );
                    },
                    icon: const Icon(Icons.done),
                    label: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 2, 148, 22),),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> onUpdateButtonClicked(int index, context) async {
  final _updateName = _updateNameController.text.trim();
  final _updateAge = _updateAgeController.text.trim();
  final _updateBatch = _updateBatchController.text.trim();
  final _updateDomain = _updateDomainController.text.trim();
  if (_updateName.isEmpty ||
      _updateAge.isEmpty ||
      _updateBatch.isEmpty ||
      _updateDomain.isEmpty) {
    return;
  } else {
    final _values = StudentModel(
        name: _updateName,
        age: _updateAge,
        batch: _updateBatch,
        domain: _updateDomain,
        image: image);
    updated(_values, index);
  }
  
}

Future<void> updated(StudentModel values, int index) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  final key = studentDb.keys;
  final saved_key = key.elementAt(index);
  studentDb.put(saved_key, values);
  studentListNotifier.notifyListeners();
  getStudent();
}
