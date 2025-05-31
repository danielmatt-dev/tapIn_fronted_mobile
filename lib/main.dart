import 'package:cron/cron.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:tapin/src/core/theme/colors.dart';
import 'package:tapin/src/features/data/auth/auth_gate.dart';
import 'package:tapin/src/features/data/data_sources/local/impl/datasource_local_impl.dart';
import 'package:tapin/src/features/data/data_sources/remote/impl/datasource_remote_impl.dart';
import 'package:tapin/src/features/domain/use_cases/consultar_asistencia_alumno.dart';
import 'package:tapin/src/features/presentation/login/pages/login_screen.dart';
import 'package:tapin/src/features/presentation/nfc/cubit/nfc_cubit.dart';
import 'package:tapin/src/shared/utils/use_case.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tapin/src/shared/utils/injections.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await initInjections();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  tz.initializeTimeZones();

  final cron = Cron();
  cron.schedule(
    Schedule.parse('0 12 * * *'), // cada día a las 12:00
        () async {
      final result = await sl<ConsultarAsistenciaAlumno>().call(NoParams());
      result.fold(
            (err) => print('Error al consultar asistencia: $err'),
            (_)   => print('Asistencia consultada y guardada'),
      );
    },
  );


  runApp(const BlocProviders());
}

class BlocProviders extends StatelessWidget {

  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NfcCubit>(
              create: (context) => sl<NfcCubit>()
          ),
        ],
        child: const MyApp()
    );
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapIn',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'),
      theme: ThemeData(
        colorScheme: colorSchemeLight,
        useMaterial3: true,
      ),
      home: AuthGate(),
    );
  }
}
