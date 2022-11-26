import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DashboardPage"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Container(
          height: 64.0,
          width: double.infinity,
          color: Colors.red,
          alignment: Alignment.center,
          child: Text("$index"),
        ),
      ),
    );
  }
}
