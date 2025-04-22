// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alumno_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlumnoRequestModel _$AlumnoRequestModelFromJson(Map<String, dynamic> json) =>
    AlumnoRequestModel(
      idNfc: json['id_nfc'] as String,
      fecha: json['fecha'] as String,
      hora: json['hora'],
      tipoAcceso: $enumDecode(_$TipoAccesoEnumMap, json['tipo_acceso']),
    );

Map<String, dynamic> _$AlumnoRequestModelToJson(AlumnoRequestModel instance) =>
    <String, dynamic>{
      'tipo_acceso': _$TipoAccesoEnumMap[instance.tipoAcceso]!,
      'hora': instance.hora,
      'fecha': instance.fecha,
      'id_nfc': instance.idNfc,
    };

const _$TipoAccesoEnumMap = {
  TipoAcceso.Entrada: 'Entrada',
  TipoAcceso.Salida: 'Salida',
};
