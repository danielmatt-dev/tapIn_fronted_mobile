import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tapin/src/features/domain/entites/alumno_response.dart';

part 'alumno_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AlumnoResponseModel extends AlumnoResponse{
  AlumnoResponseModel({required super.idNfc, required super.estado});

  factory AlumnoResponseModel.fromJson(Map<String, dynamic> json) => _$AlumnoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlumnoResponseModelToJson(this);
}