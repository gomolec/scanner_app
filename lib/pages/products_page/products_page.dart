import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductsPage"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => Container(
          height: 64.0,
          width: double.infinity,
          color: Colors.green,
          alignment: Alignment.center,
          child: Text("$index"),
        ),
      ),
    );
  }
}
