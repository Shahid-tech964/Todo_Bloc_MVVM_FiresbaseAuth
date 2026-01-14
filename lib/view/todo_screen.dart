import 'package:cubit_bloc/bloc/bloc_classes/todo_bloc.dart';
import 'package:cubit_bloc/bloc/bloc_events/todo_event.dart';
import 'package:cubit_bloc/bloc/bloc_states/todo_state.dart';
import 'package:cubit_bloc/model/local/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool isTitleFocused = false;
  bool isContentFocused = false;

  @override
  void initState() {
    context.read<TodoBloc>().add(LoadTodoEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: titleController,
          onTap: () {
            setState(() {
              isTitleFocused = true;
              isContentFocused = false;
            });
          },
          decoration: InputDecoration(
            hintText: "Title",
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isTitleFocused ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: contentController,
          maxLines: 3,
          onTap: () {
            setState(() {
              isContentFocused = true;
              isTitleFocused = false;
            });
          },
          decoration: InputDecoration(
            hintText: "Content",
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isContentFocused ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        IconButton(
          icon: Icon(Icons.add, size: 30),
          onPressed: () {
            context.read<TodoBloc>().add(
              AddEvent(
                title: titleController.text,
                content: contentController.text,
              ),
            );
          },
        ),

        SizedBox(height: 20),

        Expanded(
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoEmpty) {
                return Center(child: Text("Empty Todo"));
              } else if (state is TodoLoaded) {
                List<Todo> data = state.todos;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index].title ?? ""),
                      subtitle: Text(data[index].content ?? ""),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, size: 25),
                        onPressed: () {
                          context.read<TodoBloc>().add(
                            DeleteEvent(indx: index),
                          );
                        },
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
