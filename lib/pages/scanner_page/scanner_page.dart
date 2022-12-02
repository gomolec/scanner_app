import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatelessWidget {
  ScannerPage({Key? key}) : super(key: key);

  final MobileScannerController scannerController = MobileScannerController(
    torchEnabled: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
            fit: BoxFit.cover,
            onDetect: (barcode) {
              //print(barcode.barcodes.first.rawValue);
            },
          ),
        ],
      ),
    );
  }
}
