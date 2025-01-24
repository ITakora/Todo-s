import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';

class ListTodoWidget extends ConsumerStatefulWidget {
  const ListTodoWidget({super.key, required this.todos});

  final List<Todo> todos;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListTodoWidgetState();
}

class _ListTodoWidgetState extends ConsumerState<ListTodoWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.todos.isEmpty) {
      return Center(
        child: Text(
          "Todomu Kosong 😔",
          style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleMedium,
              fontWeight: FontWeight.w500),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Slidable(
          endActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                ref
                    .watch(todoProvider.notifier)
                    .deleteTodo(widget.todos[index].id);
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: 'Delete',
              borderRadius: BorderRadius.circular(8),
            )
          ]),
          child: SizedBox(
            width: double.infinity,
            height: 86,
            child: Card(
              color: Colors.grey,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                title: Text(
                  widget.todos[index].title,
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Text(
                  widget.todos[index].time,
                  style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
