import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';

part 'alumno_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AlumnoRequestModel {
  // id_nfc puede ser null
  final String? idNfc;
  final String? correo;
  final String fecha;
  final String hora;
  final TipoAcceso tipoAcceso;
  final String tipoRegistro;
  final String estado;

  AlumnoRequestModel({
    this.idNfc,
    this.correo,
    required this.fecha,
    required this.hora,
    required this.tipoAcceso,
    this.tipoRegistro = 'Normal',
    this.estado = 'Habilitado',
  });

  factory AlumnoRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AlumnoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlumnoRequestModelToJson(this);
}