// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alumno_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlumnoResponseModel _$AlumnoResponseModelFromJson(Map<String, dynamic> json) =>
    AlumnoResponseModel(
      idNfc: json['id_nfc'] as String,
      estado: $enumDecode(_$EstadoEnumMap, json['estado']),
    );

Map<String, dynamic> _$AlumnoResponseModelToJson(
        AlumnoResponseModel instance) =>
    <String, dynamic>{
      'estado': _$EstadoEnumMap[instance.estado]!,
      'id_nfc': instance.idNfc,
    };

const _$EstadoEnumMap = {
  Estado.Activo: 'Activo',
  Estado.Baja: 'Baja',
};
