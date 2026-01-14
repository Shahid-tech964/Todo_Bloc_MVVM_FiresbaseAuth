import 'package:cubit_bloc/bloc/bloc_events/api_events.dart';
import 'package:cubit_bloc/bloc/bloc_states/api_states.dart';
import 'package:cubit_bloc/model/remote/model_class.dart';
import 'package:cubit_bloc/model/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBloc extends Bloc<ApiEvent, BlocStates> {
  ApiRepository? repo;
  CustomBloc({this.repo}) : super(InitialState()) {
    on<FetchApiData>((event, emit) async {
      try {
        emit(Loading());
        List<model> data = await repo!.getResponse();
        emit(Success(data: data));
      } catch (e) {
        emit(Error(message: e.toString()));
      }
    });
  }
}
