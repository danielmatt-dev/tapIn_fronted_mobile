import 'package:dartz/dartz.dart';
import 'package:tapin/src/features/data/models/alumno_request_model.dart';
import 'package:tapin/src/features/data/models/alumno_response_model.dart';

abstract class DataSourceRemote{

  Future<Either<Exception, bool>> login(String email, String idToken);

  Future<Either<Exception, bool>>registrarAsistenciaALumno(AlumnoRequestModel alumno);

  Future<Either<Exception, List<AlumnoResponseModel>>>consultarAsistenciaAlumno();
}