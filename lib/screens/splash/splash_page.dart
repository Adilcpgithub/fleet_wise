import 'package:animate_do/animate_do.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              duration: Duration(milliseconds: 500),
              child: const Text(
                'Welcome to ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightGrey,
                ),
              ),
            ),
            FadeInUp(
              child: Stack(
                children: [
                  Positioned(
                    left: 15,
                    top: 55,
                    child: Image.asset('assets/untitledDesign.png', height: 40),
                  ),
                  SvgPicture.asset('assets/companyName.svg', height: 150),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
