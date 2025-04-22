import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tapin/src/features/data/data_sources/remote/datasource_remote.dart';
import 'package:tapin/src/features/data/models/alumno_request_model.dart';

class DataSourceRemoteImpl extends DataSourceRemote{
  final Dio _dio;

  DataSourceRemoteImpl({required Dio dio}): this._dio = dio;


  @override
  Future<Either<Exception, bool>> registrarAsistenciaALumno(AlumnoRequestModel alumno) {
    // TODO: implement registrarAsistenciaALumno
    throw UnimplementedError();
  }

}