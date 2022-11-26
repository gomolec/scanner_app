import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HistoryPage"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Container(
          height: 64.0,
          width: double.infinity,
          color: Colors.orange,
          alignment: Alignment.center,
          child: Text("$index"),
        ),
      ),
    );
  }
}
