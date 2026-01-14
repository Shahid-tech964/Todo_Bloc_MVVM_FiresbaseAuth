import 'package:cubit_bloc/model/local/todo_model.dart';
import 'package:hive/hive.dart';

class TodoRepository {
  Box box = Hive.box<Todo>('todoBox');

  List<Todo> getTodos() => box.values.cast<Todo>().toList();

  Future<void> addTodo(String title, String content) async {
    if (title.isNotEmpty && content.isNotEmpty) {
      await box.add(Todo(title: title, content: content));
    }
  }

  Future<void> deleteTodo(int indx) async {
    final key = box.keyAt(indx);
    await box.delete(key);
  }
}
