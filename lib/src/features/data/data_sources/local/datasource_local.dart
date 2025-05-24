import 'package:tapin/src/features/data/models/alumno_response_model.dart';

abstract class DataSourceLocal {

  String? getToken();

  Future<bool> setToken(String token);

  String? getRol();

  Future<bool> setRole(String role);

  int? getExpiracion();

  String? getFechaEmision();

  Future<bool> guardarAlumnos(List<AlumnoResponseModel> alumnos);

  List<AlumnoResponseModel> buscarListaAlumnos();

}