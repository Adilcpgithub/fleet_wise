import 'package:fleet_wise/providers/auth/auth_bloc.dart';
import 'package:fleet_wise/providers/name_update_cubit/name_update_cubit.dart';
import 'package:fleet_wise/providers/upload/upload_bloc.dart';
import 'package:fleet_wise/screens/signup/signup_address_proof_page.dart';
import 'package:fleet_wise/screens/signup/signup_phone_page.dart';
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
        //! AuthBlocProvider
        BlocProvider(create: (_) => AuthBloc()),
        //! NameUpdateCubitProvider
        BlocProvider(create: (_) => NameUpdateCubit()),
        // ! Upload document BlocProvider adhardhar front and back etc
        BlocProvider(create: (_) => UploadBloc()),
      ],
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
        home: SignupAddressProofPage(name: 's'),
      ),
    );
  }
}
