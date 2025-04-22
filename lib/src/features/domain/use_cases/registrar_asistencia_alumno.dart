import 'package:dartz/dartz.dart';
import 'package:tapin/src/features/data/data_sources/remote/datasource_remote.dart';
import 'package:tapin/src/features/data/mapper/alumno_mapper_implement.dart';
import 'package:tapin/src/features/domain/entites/alumno_request.dart';
import 'package:tapin/src/shared/utils/use_case.dart';

class RegistrarAsistenciaAlumno extends UseCase<bool, AlumnoRequest>{

  final DataSourceRemote _remote;

  final AlumnoMapperImplement _alumnoMapperImplement;

  RegistrarAsistenciaAlumno({required DataSourceRemote remote, required AlumnoMapperImplement mapper}): _remote = remote, _alumnoMapperImplement = mapper;

  @override
  Future<Either<Exception, bool>> call(AlumnoRequest params) async {
    return _remote.registrarAsistenciaALumno(_alumnoMapperImplement.toModel(params));
  }
}