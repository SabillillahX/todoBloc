/*

  DATABASE REPOSITORY

 */

import 'package:isar/isar.dart';
import 'package:myapp/data/models/isar_todo.dart';
import 'package:myapp/domain/models/todo.dart';
import 'package:myapp/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  // database
  final Isar db;

  IsarTodoRepo(this.db);

  // get todos
  @override
  Future<List<Todo>> getTodos() async {
    // fetch from db
    final todos = await db.todoIsars.where().findAll();

    // return as list of todos and gives to domain layer
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  // add todos
  @override
  Future<void> addTodo(Todo newTodo) async {
    // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(newTodo);

    // we can store it in our isar db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));

  }

  // update todos
  @override
  Future<void> updateTodo(Todo todo) async {
        // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(todo);

    // we can store it in our isar db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
    
  }

  // delete todos
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}
