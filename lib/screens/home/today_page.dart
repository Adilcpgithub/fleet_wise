import 'package:flutter/material.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today's Data")),
      body: Center(
        child: const Text("Data for Today", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
