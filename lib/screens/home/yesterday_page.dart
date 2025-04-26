import 'package:flutter/material.dart';

class YesterdayPage extends StatelessWidget {
  const YesterdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yesterday's Data")),
      body: Center(
        child: const Text("Data for Yesterday", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
