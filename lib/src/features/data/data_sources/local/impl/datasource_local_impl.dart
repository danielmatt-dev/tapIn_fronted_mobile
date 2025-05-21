import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapin/src/features/data/data_sources/local/datasource_local.dart';
import 'package:tapin/src/features/data/models/alumno_response_model.dart';

class DataSourceLocalImpl extends DataSourceLocal {

  final SharedPreferences _sharedPreferences;

  DataSourceLocalImpl({required SharedPreferences sharedPreferences}):
        _sharedPreferences = sharedPreferences;

  @override
  String? getToken() {
    return _sharedPreferences.getString("token");
  }

  @override
  Future<bool> setToken(String token) async {
    return await _sharedPreferences.setString("token", token);
  }

  @override
  List<AlumnoResponseModel> buscarListaAlumnos() {
    final alumnosJson = _sharedPreferences.getStringList("alumnos");

    if (alumnosJson == null || alumnosJson.isEmpty){
      return [];
    }

    final alumnosMap = alumnosJson.map((json) => jsonDecode(json) as Map<String,dynamic>).toList();
    return alumnosMap.map((map) => AlumnoResponseModel.fromJson(map)).toList();
  }

  @override
  Future<bool> guardarAlumnos(List<AlumnoResponseModel> alumnos) async {
    final alumnosJson = alumnos.map((alumno) => jsonEncode(alumno.toJson())).toList();
    return await _sharedPreferences.setStringList("alumnos", alumnosJson);
  }

}