import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tapin/src/features/data/auth/google_auth_service.dart';
import 'package:tapin/src/features/data/data_sources/local/datasource_local.dart';
import 'package:tapin/src/features/data/data_sources/remote/datasource_remote.dart';
import 'package:tapin/src/features/data/data_sources/remote/impl/datasource_remote_impl.dart';
import 'package:tapin/src/features/data/mapper/alumno_mapper_implement.dart';
import 'package:tapin/src/features/domain/use_cases/consultar_asistencia_alumno.dart';
import 'package:tapin/src/features/domain/use_cases/registrar_asistencia_alumno.dart';
import 'package:tapin/src/shared/utils/injections.dart';

initRobertInjections() async{

  /* Datasource remote */
  sl.registerSingleton<DataSourceRemote>(
      DataSourceRemoteImpl(dio: sl(), datasourcelocal: sl()), );

  sl.registerSingleton<AlumnoMapperImplement>(
    AlumnoMapperImplement());

  sl.registerSingleton<GoogleAuthService>(GoogleAuthService());

  sl.registerSingleton<RegistrarAsistenciaAlumno>(
    RegistrarAsistenciaAlumno(mapper: sl(), remote: sl()));

  sl.registerSingleton<ConsultarAsistenciaAlumno>(
    ConsultarAsistenciaAlumno(remote: sl(), local: sl()));

  sl<DataSourceLocal>().setToken(dotenv.get('TOKEN'));

}