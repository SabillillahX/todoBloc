/*

  TO DO CUBIT - simple state management

 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domain/models/todo.dart';
import 'package:myapp/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  // reference todo repository
  final TodoRepo todoRepo;

  // contruction initializes the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // LOAD
  Future<void> loadTodos() async {
    // fetched list from todos
    final todoList = await todoRepo.getTodos();

    // emit the fatched list as the new state
    emit(todoList);
  }

  // ADD
  Future<void> addTodo(String text) async {
    // create a new todo with unique id
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);

    // save the new todo to new repo
    await todoRepo.addTodo(newTodo);
    // reload
    loadTodos();
  }

  // DELETE
  Future<void> deleteTodo(Todo todo) async {
    // delete provided todo from repo
    await todoRepo.deleteTodo(todo);

    // reload
    loadTodos();
  }

  // TOGGLE
  Future<void> toggleCompletion(Todo todo) async {
    // toggle the completion status of provided todo
    final updatedTodo = todo.toggleCompletion();

    // update the todo in repo with new completion status
    await todoRepo.updateTodo(updatedTodo);

    // reload
    loadTodos();
  }
}
