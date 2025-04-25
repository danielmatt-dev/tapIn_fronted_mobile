import 'package:dartz/dartz.dart';
import 'package:tapin/src/features/data/data_sources/remote/datasource_remote.dart';
import 'package:tapin/src/shared/utils/use_case.dart';

class ConsultarAsistenciaAlumno extends UseCase<bool, NoParams> {
  final DataSourceRemote _remote;

  ConsultarAsistenciaAlumno({ required DataSourceRemote remote }):
      _remote = remote;

  @override
  Future<Either<Exception, bool>> call(NoParams params) async {
    return _remote.consultarAsistenciaAlumno();
  }
}