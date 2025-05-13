import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:tapin/src/core/theme/colors.dart';
import 'package:tapin/src/features/presentation/login/pages/login_screen.dart';
import 'package:tapin/src/features/presentation/nfc/cubit/nfc_cubit.dart';
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
      locale: const Locale('es'),
      theme: ThemeData(
        colorScheme: colorSchemeLight,
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
