import 'package:cubit_bloc/model/remote/model_class.dart';

class BlocStates{}

class InitialState extends BlocStates{
  
}

class Loading extends BlocStates {}

class Success extends BlocStates {
  List<model>? data;
  Success({required this.data});
}

class Error extends BlocStates {
  String? message;
  Error({required this.message});
}
