import 'package:cubit_bloc/model/local/todo_model.dart';

abstract class TodoState {}

class TodoEmpty extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  TodoLoaded({required this.todos});
}
