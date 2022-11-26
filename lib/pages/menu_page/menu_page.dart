import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MenuPage"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Container(
          height: 64.0,
          width: double.infinity,
          color: Colors.yellow,
          alignment: Alignment.center,
          child: Text("$index"),
        ),
      ),
    );
  }
}
