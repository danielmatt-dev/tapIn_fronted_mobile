import 'package:tapin/src/features/data/models/alumno_response_model.dart';

abstract class DataSourceLocal {

  String? getToken();

  Future<bool> setToken(String token);

  String? getRole();

  Future<bool> setRole(String role);

  Future<bool> guardarAlumnos(List<AlumnoResponseModel> alumnos);

  List<AlumnoResponseModel> buscarListaAlumnos();

}