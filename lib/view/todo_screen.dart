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
    super.initState();
    context.read<TodoBloc>().add(LoadTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE FIELD
        TextField(
          controller: titleController,
          onChanged: (text) {
            context.read<TitleValidationBloc>().add(
              TitleChangeEvent(title: text),
            );
          },
          onTap: () {
            setState(() {
              isTitleFocused = true;
              isContentFocused = false;
            });
          },
          decoration: InputDecoration(
            hintText: "Title",
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isTitleFocused ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),

        const SizedBox(height: 3),

        /// TITLE ERROR
        BlocBuilder<TitleValidationBloc, String>(
          builder: (context, state) {
            return Text(
              state.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.red),
            );
          },
        ),

        const SizedBox(height: 12),

        /// CONTENT FIELD
        TextField(
          controller: contentController,
          maxLines: 3,
          onChanged: (text) {
            context.read<ContentValidationBloc>().add(
              ContentChangeEvent(content: text),
            );
          },
          onTap: () {
            setState(() {
              isContentFocused = true;
              isTitleFocused = false;
            });
          },
          decoration: InputDecoration(
            hintText: "Content",
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isContentFocused ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),

        const SizedBox(height: 3),

        /// CONTENT ERROR
        BlocBuilder<ContentValidationBloc, String>(
          builder: (context, state) {
            return Text(
              state.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.red),
            );
          },
        ),

        const SizedBox(height: 16),

        /// ADD BUTTON
         Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.add, size: 30),
              onPressed: () {
                context.read<TodoBloc>().add(
                  AddEvent(
                    title: titleController.text,
                    content: contentController.text,
                  ),
                );
              },
            ),
          ),
        

        const SizedBox(height: 20),

        /// TODO LIST (ONLY HERE Expanded IS CORRECT)
        Expanded(
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoEmpty) {
                return const Center(child: Text("Empty Todo"));
              } else if (state is TodoLoaded) {
                final data = state.todos;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index].title ?? ""),
                      subtitle: Text(data[index].content ?? ""),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, size: 25),
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
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
