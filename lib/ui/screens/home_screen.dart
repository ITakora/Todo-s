import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/ui/screens/todo_field_screen.dart';
import 'package:todo/ui/widgets/list_todo.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _todoFuture;

  @override
  void initState() {
    _todoFuture = ref.read(todoProvider.notifier).loadTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text("Todo's ",
                style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _todoFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListTodoWidget(todos: todos),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: 65,
          height: 65,
          child: FloatingActionButton(
            backgroundColor: Colors.grey,
            child: const Icon(
              Icons.add,
              size: 34,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TodoFieldScreen(),
              ));
            },
          ),
        ),
      ),
    );
  }
}
