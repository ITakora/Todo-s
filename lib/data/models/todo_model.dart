import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Todo {
  String id;
  String title;
  String time;

  Todo({required this.title, required this.time, String? id})
      : id = id ?? uuid.v4();

  // factory Todo.fromJson(Map<String, dynamic> json) => Todo(
  //       title: json["title"],
  //       time: json["Time"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "Judul": title,
  //       "Time": time,
  //     };
}
