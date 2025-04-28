import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/providers/auth/auth_bloc.dart';
import 'package:fleet_wise/providers/auth/auth_event.dart';
import 'package:fleet_wise/providers/auth/auth_state.dart';
import 'package:fleet_wise/screens/home/home_page.dart';
import 'package:fleet_wise/screens/signup/signup_phone_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AutoLoginEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          await Future.delayed(const Duration(seconds: 2));
          if (state is AuthAutoLoginSuccess) {
            //! AuthAutoLoginSuccess go to home page
            log('Auto Login Success ');
            // ignore: use_build_context_synchronously
            CustomNavigation.pushReplacement(context, HomePage());
          } else {
            //! AuthAutoFailed go to signupPhoneNo page
            log('Auto Login Failed');
            // ignore: use_build_context_synchronously
            CustomNavigation.pushReplacement(context, SignupPhoneNo());
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeIn(
                duration: Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Welcome to ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              ),
              FadeInUp(
                child: Stack(
                  children: [
                    Positioned(
                      left: 15,
                      top: 60,
                      child: Image.asset(
                        'assets/untitledDesign.png',
                        height: 55,
                      ),
                    ),
                    SvgPicture.asset('assets/companyName.svg', height: 180),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
