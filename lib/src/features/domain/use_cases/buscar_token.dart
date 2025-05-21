import 'package:tapin/src/features/data/data_sources/local/datasource_local.dart';

class BuscarToken {

  final DataSourceLocal _local;

  BuscarToken({ required DataSourceLocal local }): _local = local;

  String call(params) {
    return _local.getToken() ?? "";
  }

}