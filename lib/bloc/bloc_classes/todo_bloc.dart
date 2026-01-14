import 'package:cubit_bloc/bloc/bloc_events/todo_event.dart';
import 'package:cubit_bloc/bloc/bloc_states/todo_state.dart';
import 'package:cubit_bloc/model/local/todo_model.dart';
import 'package:cubit_bloc/model/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoRepository? repo;
  TodoBloc({required this.repo}) : super(TodoEmpty()) {
    on<LoadTodoEvent>((event, emit) async {
      if (repo!.getTodos().isNotEmpty) {
        emit(TodoLoaded(todos: repo!.getTodos()));
      } else {
        emit(TodoEmpty());
      }
    });

    on<AddEvent>((event, emit) async {
      if (event.title!.isNotEmpty && event.content!.isNotEmpty) {
        await repo!.addTodo(event.title ?? "", event.content ?? "");
        List<Todo> data = repo!.getTodos();
        emit(TodoLoaded(todos: data));
      }
    });

    on<DeleteEvent>((event, emit) async {
      await repo!.deleteTodo(event.indx ?? 0);
      List<Todo> data = repo!.getTodos();
      emit(TodoLoaded(todos: data));
    });
  }
}
