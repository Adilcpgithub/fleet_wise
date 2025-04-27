import 'package:flutter/material.dart';

class ThisWeekPage extends StatelessWidget {
  const ThisWeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("This Week's Data")),
      body: Column(
        children: [
          Center(
            child: const Text(
              "Data for This Week",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Center(
            child: const Text(
              "Data for This Week",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Center(
            child: const Text(
              "Data for This Week",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
