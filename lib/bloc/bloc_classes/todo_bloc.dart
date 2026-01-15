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

class TitleValidationBloc extends Bloc<TodoEvent, String> {
  TitleValidationBloc() : super("") {
    on<TitleChangeEvent>((event, emit) async {
      if (event.title!.isEmpty) {
        emit("Please Enter Title");
      } else if (event.title!.length < 6) {
        emit("Title should't contain less than 6 character");
      } else {
        emit("");
      }
    });
  }
}

class ContentValidationBloc extends Bloc<TodoEvent, String> {
  ContentValidationBloc() : super("") {
    on<ContentChangeEvent>((event, emit) async {
      if (event.content!.isEmpty) {
        emit("Please Enter Content");
      } else {
        emit("");
      }
    });
  }
}
