import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tapin/src/features/data/data_sources/remote/datasource_remote.dart';
import 'package:tapin/src/features/data/data_sources/remote/endpoints/datasource_remote_endpoints.dart';
import 'package:tapin/src/features/data/models/alumno_request_model.dart';
import 'package:tapin/src/features/data/models/alumno_response_model.dart';
import 'package:tapin/src/shared/exceptions/exceptions.dart';

import '../../local/datasource_local.dart';

class DataSourceRemoteImpl extends DataSourceRemote{
  final Dio _dio;
  final DataSourceLocal _datasourcelocal;
  Map<String, dynamic> _headers = {};

  DataSourceRemoteImpl({required Dio dio, required DataSourceLocal datasourcelocal}):
        _dio = dio,
        _datasourcelocal = datasourcelocal{
        _headers = {
          'Authorization': 'Bearer ${_datasourcelocal.getToken()}',
          'Content-Type': 'application/json',
        };
        }


  @override
  Future<Either<Exception, bool>> registrarAsistenciaALumno(AlumnoRequestModel alumno) async {
    try{
      final endpoint = DataSourceRemoteEndpoints.post;
      final response = await _dio.post(endpoint,
      data: alumno.toJson(),
      options: Options(
        headers: _headers
      )
      );

      if(response.statusCode == 200){
        return const Right(true);
      }
      return const Right(false);
    }on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return Left(TimeoutException());
      }

      final statusCode = e.response?.statusCode;
      if (statusCode == 400) {
        return Left(BadRequestException());
      }
      if (statusCode == 401) {
        return Left(BadCredentialsException());
      }
      if (statusCode == 403) {
        return Left(ForBittenException());
      }
      if (statusCode == 404) {
        return Left(ResourceNotFoundException());
      }

      return Left(Exception('HTTP ${statusCode ?? 'error'}: ${e.message}'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<AlumnoResponseModel>>> consultarAsistenciaAlumno() async {
    try{
      final endpoint = DataSourceRemoteEndpoints.get;
      final response = await _dio.get(
        endpoint,
        options: Options(headers: _headers),
      );

      if(response.statusCode == 200){
        final data = response.data as List<dynamic>;
        final lista = data
        .map((json) => AlumnoResponseModel.fromJson(json as Map<String, dynamic>))
        .toList();
        return Right(lista);
      }
      return const Right(<AlumnoResponseModel>[]);
    }on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return Left(TimeoutException());
      }

      final statusCode = e.response?.statusCode;
      if (statusCode == 400) {
        return Left(BadRequestException());
      }
      if (statusCode == 401) {
        return Left(BadCredentialsException());
      }
      if (statusCode == 403) {
        return Left(ForBittenException());
      }
      if (statusCode == 404) {
        return Left(ResourceNotFoundException());
      }

      return Left(Exception('HTTP ${statusCode ?? 'error'}: ${e.message}'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

}