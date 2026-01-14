import 'dart:convert';

import 'package:cubit_bloc/model/remote/apiService.dart';
import 'package:cubit_bloc/model/remote/model_class.dart';

class ApiRepository {
  List<model> _list_model = [];
  Apiservice service = Apiservice();

  Future<List<model>> getResponse() async {
    var response = await service.getjson();
    if (response.statusCode == 200) {
      List<dynamic> map = jsonDecode(response.body);

      for (var i in map) {
        _list_model.add(model.fromJson(i));
      }
    } else {
      throw Exception("Something went wrong");
    }

    return _list_model;
  }
}
