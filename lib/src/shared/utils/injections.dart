import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapin/src/shared/utils/robert_injections.dart';

final sl = GetIt.instance;

initInjections() async {

  /*  Dio  */
  sl.registerSingleton<Dio>(
      Dio(
        BaseOptions(
            connectTimeout: const Duration(seconds: 45),
            receiveTimeout: const Duration(seconds: 45),
            sendTimeout: const Duration(seconds: 45)
        ),
      ));

  /*  Shared Preferences  */
  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  initRobertInjections();
}
