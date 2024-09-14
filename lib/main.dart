import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:myapp/data/models/isar_todo.dart';
import 'package:myapp/data/repository/isar_todo_repo.dart';
import 'package:myapp/domain/repository/todo_repo.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get directory path to storing data
  final dir = await getApplicationDocumentsDirectory();

  // open isar database
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  // init the repo with isar database
  final isarTodoRepo = IsarTodoRepo(isar);

  // run app
  runApp(MyApp(
    todoRepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  // database injection through the app
  final TodoRepo todoRepo;

  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
