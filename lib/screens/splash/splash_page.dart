import 'package:animate_do/animate_do.dart';
import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/core/theme/app_colors.dart';
import 'package:fleet_wise/screens/home/home_page.dart';
import 'package:fleet_wise/screens/signup/signup_phone_page.dart';
import 'package:fleet_wise/services/auth_service.dart';
import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:fleet_wise/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = SecureStorageService();
  final authService = AuthService.instance;
  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // For splash animation
    final storage = SecureStorageService();
    final authService = AuthService.instance;
    final tokenService = TokenService.instance;

    // Inject dependencies safely AFTER both singletons exist
    authService.init(storage: storage, token: tokenService);
    tokenService.init(storage: storage, auth: authService);

    final accessToken = await storage.getAccessToken();
    final refreshToken = await storage.getRefreshToken();

    if (accessToken != null &&
        accessToken.isNotEmpty &&
        refreshToken != null &&
        refreshToken.isNotEmpty) {
      // ignore: use_build_context_synchronously
      CustomNavigation.pushReplacement(context, HomePage());
      //! creating new Access token
      //  authService.refreshAccessToken(refreshToken);
    } else {
      // ignore: use_build_context_synchronously
      CustomNavigation.pushReplacement(context, SignupPhoneNo());
    }
  }

  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.baseColor,
      body: Center(
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
                    child: Image.asset('assets/untitledDesign.png', height: 55),
                  ),
                  SvgPicture.asset('assets/companyName.svg', height: 180),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
