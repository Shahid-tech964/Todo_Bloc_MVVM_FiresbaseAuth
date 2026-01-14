import 'package:cubit_bloc/bloc/bloc_classes/api_bloc.dart';
import 'package:cubit_bloc/bloc/bloc_states/api_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomBloc, BlocStates>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(color: Colors.greenAccent),
          );
        } else if (state is Success) {
          // List<model> data = (state as Success).data ?? [];
          return ListView.builder(
            itemCount: state.data?.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(state.data![index].title ?? ""),
                subtitle: Text(state.data![index].body ?? ""),
              );
            },
          );
        } else if (state is Error) {
          return Center(child: Text(state.message ?? ""));
        } else {
          return Center(child: Text("Nothing found"));
        }
      },
    );
  }
}
