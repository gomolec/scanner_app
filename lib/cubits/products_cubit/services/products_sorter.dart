import 'package:scanner_app/models/product_model.dart';

class ProductsSorter {
  List<Product> sortByPinned(List<Product> products) {
    return products..sort((a, b) => a.marked || !b.marked ? -1 : 1);
  }

  List<Product> sortByName(List<Product> products) {
    return products..sort((a, b) => a.name.compareTo(b.name));
  }
}
