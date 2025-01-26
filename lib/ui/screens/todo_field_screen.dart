import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/ui/widgets/time_picker.dart';

class TodoFieldScreen extends ConsumerStatefulWidget {
  const TodoFieldScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoFieldScreenState();
}

class _TodoFieldScreenState extends ConsumerState<TodoFieldScreen> {
  Time _time = Time(hour: 00, minute: 00, second: 00);
  final _titleController = TextEditingController();

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
      // print(_time);
    });
  }

  void _saveTodo() {
    final submitTitle = _titleController.text;

    if (submitTitle.isEmpty) {
      return;
    }

    ref.read(todoProvider.notifier).addTodo(submitTitle, _time.format(context));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _saveTodo();
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.grey)),
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Judul Todo",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              )),
        ),
        TimePickerWidget(time: _time, onTimeChanged: onTimeChanged)
      ]),
    );
  }
}
