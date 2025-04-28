import 'package:dartz/dartz.dart';
import 'package:tapin/src/features/data/data_sources/local/datasource_local.dart';
import 'package:tapin/src/features/data/data_sources/remote/datasource_remote.dart';
import 'package:tapin/src/shared/utils/use_case.dart';

class ConsultarAsistenciaAlumno extends UseCase<bool, NoParams> {
  final DataSourceRemote _remote;
  final DataSourceLocal _local;

  ConsultarAsistenciaAlumno({ required DataSourceRemote remote, required DataSourceLocal local}):
      _remote = remote,
      _local = local;

  @override
  Future<Either<Exception, bool>> call(NoParams params) async {
    final resultado = await _remote.consultarAsistenciaAlumno();

    return resultado.fold(
          (ex) async => Left(ex),
          (alumnos) async {
            await _local.guardarAlumnos(alumnos);
            return Right(true);
      },
    );
  }
}