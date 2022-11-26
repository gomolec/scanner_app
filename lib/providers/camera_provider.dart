import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraProvider extends ChangeNotifier {
  final int routeIndex;
  final TabsRouter tabsRouter;
  final MobileScannerController scannerController;
  late final StreamSubscription scannerSubscription;
  bool scanning = false;

  CameraProvider({
    required this.routeIndex,
    required this.tabsRouter,
    required this.scannerController,
  });

  void subscribe() async {
    debugPrint("Subscribe");
    tabsRouter.addListener(_tabsRouterListener);
    scannerSubscription =
        scannerController.barcodes.listen((event) => _scannerListener(event));
  }

  void _tabsRouterListener() async {
    print(tabsRouter.activeIndex);
    if (tabsRouter.activeIndex == routeIndex) {
      scanning = true;
      debugPrint("Scanner Start");
      notifyListeners();
    } else {
      scanning = false;
      debugPrint("Scanner Stop");
      notifyListeners();
    }
  }

  void _scannerListener(BarcodeCapture barcode) {
    if (barcode.barcodes.first.rawValue == null) {
      debugPrint('Failed to scan Barcode');
    } else {
      final String code = barcode.barcodes.first.rawValue!;
      debugPrint('Barcode found! $code');
      // int index = context
      //     .read<ProductListCubit>()
      //     .products
      //     .indexWhere((element) => element.code == code);
      // if (index >= 0) {
      //   Navigator.popAndPushNamed(
      //     context,
      //     '/product',
      //     arguments: context.read<ProductListCubit>().products[index],
      //   );
      // }
    }
  }

  @override
  void dispose() {
    tabsRouter.removeListener(_tabsRouterListener);
    scannerSubscription.cancel();
    super.dispose();
  }
}
