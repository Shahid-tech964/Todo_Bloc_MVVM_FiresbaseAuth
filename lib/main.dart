import 'package:cubit_bloc/bloc/bloc_classes/todo_bloc.dart';

import 'package:cubit_bloc/model/local/todo_model.dart';

import 'package:cubit_bloc/model/repository/todo_repository.dart';

import 'package:cubit_bloc/view/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todoBox');

  TodoRepository repository = TodoRepository();
  runApp(
    BlocProvider(
      create: (_) => TodoBloc(repo: repository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // context.read<CustomBloc>().add(FetchApiData());
    // // TODO: implement initState
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: Padding(
            padding: EdgeInsetsGeometry.directional(
              top: 30,
              start: 15,
              end: 15,
            ),
            child: AddTodoView(),
          ),
        ),
      ),
    );
  }
}



