import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  final String date;
  @HiveField(3)
  String value;
  @HiveField(4)
  String status;
  @HiveField(5)
  int color;

  NoteModel({
    required this.name,
    required this.age,
    required this.date,
    required this.value,
    required this.status,
    required this.color,
  });



}
