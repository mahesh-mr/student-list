import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:students_corner/function/model_student.dart';
import 'package:students_corner/home_login.dart';

Future<void> main(List<String> args) async {
  
  WidgetsFlutterBinding.ensureInitialized();

   await Hive.initFlutter();
   
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenHome(),
    );
  }
  
}

