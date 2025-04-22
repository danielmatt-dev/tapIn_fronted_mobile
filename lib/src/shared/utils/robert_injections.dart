import 'package:tapin/src/features/data/data_sources/remote/datasource_remote.dart';
import 'package:tapin/src/features/data/data_sources/remote/impl/datasource_remote_impl.dart';
import 'package:tapin/src/shared/utils/injections.dart';

initRobertInjections() async{

  /* Datasource remote */
  sl.registerSingleton<DataSourceRemote>(
      DataSourceRemoteImpl(dio: sl()));

}