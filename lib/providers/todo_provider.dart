import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'todos.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE todos(id TEXT PRIMARY KEY, title TEXT, time TEXT)');
  }, version: 1);

  return db;
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super(const []);

  Future<void> loadTodo() async {
    final db = await _getDatabase();
    final data = await db.query('todos');
    final todos = data
        .map((row) => Todo(
              id: row['id'] as String,
              title: row['title'] as String,
              time: row['time'] as String,
            ))
        .toList();

    state = todos;
  }

  void addTodo(String title, String time) async {
    final newTodos = Todo(
      title: title,
      time: time,
    );
    state = [newTodos, ...state];
    final db = await _getDatabase();
    db.insert('todos',
        {'id': newTodos.id, 'title': newTodos.title, 'time': newTodos.time});
  }

  void deleteTodo(String id) async {
    final db = await _getDatabase();
    db.delete('todos', where: 'id = ?', whereArgs: [id]);
    loadTodo();
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier(),
);
