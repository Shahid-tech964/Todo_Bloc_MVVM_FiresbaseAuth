class TodoEvent {}

class AddEvent extends TodoEvent {
  String? title;

  String? content;

  AddEvent({required this.title, required this.content});
}

class DeleteEvent extends TodoEvent {
  int? indx;

  DeleteEvent({required this.indx});
}

class LoadTodoEvent extends TodoEvent{}