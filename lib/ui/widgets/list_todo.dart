import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTodoWidget extends StatelessWidget {
  const ListTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Text(
              "Bermain",
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 19),
            child: Text(
              "20.00",
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
