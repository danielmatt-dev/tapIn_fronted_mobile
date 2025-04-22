import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapin/src/features/data/data_sources/local/datasource_local.dart';

class DataSourceLocalImpl extends DataSourceLocal {

  final SharedPreferences _sharedPreferences;

  DataSourceLocalImpl({required SharedPreferences sharedPreferences}):
        _sharedPreferences = sharedPreferences;

  @override
  String getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<bool> setToken(String token) {
    // TODO: implement setToken
    throw UnimplementedError();
  }

}