import 'package:tapin/src/features/data/data_sources/local/datasource_local.dart';
import 'package:tapin/src/features/data/data_sources/local/impl/datasource_local_impl.dart';
import 'package:tapin/src/features/domain/use_cases/buscar_token.dart';
import 'package:tapin/src/features/domain/use_cases/escanear_nfc.dart';
import 'package:tapin/src/shared/utils/injections.dart';

initDanielInjections() async {

  /*  Datasource Local */
  sl.registerSingleton<DataSourceLocal>(
      DataSourceLocalImpl(sharedPreferences: sl()));

  /*  Use Cases  */
  sl.registerSingleton<BuscarToken>(
      BuscarToken(local: sl()));

  sl.registerSingleton<EscanearNFC>(EscanearNFC());

}