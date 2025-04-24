import 'package:fleet_wise/screens/signup/signup_address_proof_page.dart';
import 'package:fleet_wise/screens/signup/signup_name_page.dart';
import 'package:fleet_wise/screens/signup/signup_otp_page.dart';
import 'package:fleet_wise/screens/signup/signup_phone_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: SignupAddressProofPage(),
    );
  }
}
