import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';

part 'alumno_request_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AlumnoRequestModel extends AlumnoRequest{

  AlumnoRequestModel({required super.idNfc, required super.fecha, required super.hora, required super.tipoAcceso});

  factory AlumnoRequestModel.fromJson(Map<String, dynamic> json) => _$AlumnoRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlumnoRequestModelToJson(this);
}