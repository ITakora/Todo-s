import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class TodoFieldScreen extends StatefulWidget {
  const TodoFieldScreen({super.key});

  @override
  State<TodoFieldScreen> createState() => _TodoFieldScreenState();
}

class _TodoFieldScreenState extends State<TodoFieldScreen> {
  Time _time = Time(hour: 00, minute: 00, second: 00);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
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
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              decoration: InputDecoration(
            hintText: "Judul Todo",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          )),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              showPicker(
                  context: context,
                  value: _time,
                  moonAsset: Image.asset('assets/images/moon.png'),
                  sunAsset: Image.asset("assets/images/sun.png"),
                  sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                  sunset: TimeOfDay(hour: 18, minute: 0), // optional
                  duskSpanInMinutes: 120, // optional
                  onChange: onTimeChanged,
                  is24HrFormat: true),
            );
          },
          child: Text(
            "Open time picker",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ]),
    );
  }
}
