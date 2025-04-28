import 'package:fleet_wise/core/widgets/toast_message_custom.dart';
import 'package:fleet_wise/providers/auth/auth_bloc.dart';
import 'package:fleet_wise/providers/cubit_connectivity/connectivitiy_cubit.dart';
import 'package:fleet_wise/providers/name_update_cubit/name_update_cubit.dart';
import 'package:fleet_wise/providers/pnl_providers/monthly_pnl_bloc/monthly_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl_bloc/today_pnl_bloc.dart';
import 'package:fleet_wise/providers/pnl_providers/yesterday_pnl_bloc/yesterday_pnl_bloc.dart';
import 'package:fleet_wise/providers/upload/upload_bloc.dart';
import 'package:fleet_wise/screens/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //!Connectivity Provider
        BlocProvider(create: (_) => ConnectivityCubit()),
        //! AuthBlocProvider
        BlocProvider(create: (_) => AuthBloc()),
        //! NameUpdateCubitProvider
        BlocProvider(create: (_) => NameUpdateCubit()),
        // ! Upload document BlocProvider adhardhar front and back etc
        BlocProvider(create: (_) => UploadBloc()),
        //! TodayPnLBlocProvider
        BlocProvider(create: (_) => TodayPnLBloc()),
        //! YesterdayPnLBlocProvider
        BlocProvider(create: (_) => YesterdayPnlBloc()),
        //! MonthlyPnLBlocProvider
        BlocProvider(create: (_) => MonthlyPnlBloc()),
      ],
      child: BlocListener<ConnectivityCubit, bool>(
        listener: (context, state) {
          if (!state) {
            customToastMessage('You are offline');
          }
        },
        child: MaterialApp(
          locale: Locale('en'),
          supportedLocales: const [
            Locale('en'), //!English
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'FleetWise',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}
