import 'package:fleet_wise/core/navigation/navigation_service.dart';
import 'package:fleet_wise/screens/signup/signup_phone_page.dart';
import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                final SecureStorageService storage = SecureStorageService();
                storage.clearTokens();
                CustomNavigation.pushAndRemoveUntil(context, SignupPhoneNo());
              },
              child: Text('Logout'),
            ),
            Text('Account Page'),
          ],
        ),
      ),
    );
  }
}
