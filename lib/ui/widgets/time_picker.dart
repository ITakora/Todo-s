import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatelessWidget {
  const TimePickerWidget(
      {super.key, required this.time, required this.onTimeChanged});

  final Time time;
  final void Function(Time newTime) onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
          elevation: WidgetStatePropertyAll(0.0),
          backgroundColor: WidgetStatePropertyAll(Colors.white)),
      onPressed: () {
        Navigator.of(context).push(
          showPicker(
              context: context,
              value: time,
              moonAsset: Image.asset('assets/images/moon.png'),
              sunAsset: Image.asset("assets/images/sun.png"),
              sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
              sunset: const TimeOfDay(hour: 18, minute: 0), // optional
              duskSpanInMinutes: 120, // optional
              onChange: onTimeChanged,
              is24HrFormat: true),
        );
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select Time",
            style: TextStyle(color: Colors.black),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
