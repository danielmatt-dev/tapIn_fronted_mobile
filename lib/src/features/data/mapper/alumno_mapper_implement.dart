import 'package:tapin/src/features/data/models/alumno_request_model.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/shared/utils/mapper.dart';

class AlumnoMapperImplement extends Mapper<AlumnoRequest, AlumnoRequestModel>{
  @override
  AlumnoRequest toEntity(AlumnoRequestModel model) {
    return AlumnoRequest(idNfc: model.idNfc, fecha: model.fecha, hora: model.hora, tipoAcceso: model.tipoAcceso);
  }

  @override
  AlumnoRequestModel toModel(AlumnoRequest entity) {
    return AlumnoRequestModel(
        idNfc: entity.idNfc,
        correo: entity.correo,
        fecha: entity.fecha,
        hora: entity.hora,
        tipoAcceso: entity.tipoAcceso);
  }

}