// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alumno_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlumnoRequestModel _$AlumnoRequestModelFromJson(Map<String, dynamic> json) =>
    AlumnoRequestModel(
      idNfc: json['id_nfc'] as String?,
      correo: json['correo'] as String?,
      fecha: json['fecha'] as String,
      hora: json['hora'] as String,
      tipoAcceso: $enumDecode(_$TipoAccesoEnumMap, json['tipo_acceso']),
      tipoRegistro: json['tipo_registro'] as String? ?? 'Normal',
      estado: json['estado'] as String? ?? 'Habilitado',
    );

Map<String, dynamic> _$AlumnoRequestModelToJson(AlumnoRequestModel instance) =>
    <String, dynamic>{
      'id_nfc': instance.idNfc,
      'correo': instance.correo,
      'fecha': instance.fecha,
      'hora': instance.hora,
      'tipo_acceso': _$TipoAccesoEnumMap[instance.tipoAcceso]!,
      'tipo_registro': instance.tipoRegistro,
      'estado': instance.estado,
    };

const _$TipoAccesoEnumMap = {
  TipoAcceso.Entrada: 'Entrada',
  TipoAcceso.Salida: 'Salida',
};
