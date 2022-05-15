import 'package:hive_flutter/hive_flutter.dart';
part 'model_student.g.dart';
@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String batch;
  @HiveField(3)
  final String domain;
  @HiveField(4)
  final image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.batch,
      required this.domain,
      required this.image,
      });
}
