import 'package:scanner_app/models/models.dart';
import 'package:scanner_app/pages/products_page/models/models.dart';

class ProductsSorter {
  List<Product> sortProducts({
    required List<Product> products,
    required ProductsFilter filter,
  }) {
    List<Product> filteredProducts = products;

    if (filter.showCompleted == false && filter.showMarked == false) {
      filteredProducts.removeWhere((element) =>
          element.quantity >= element.targetQuantity || element.marked == true);
    } else if (filter.showCompleted == false) {
      filteredProducts
          .removeWhere((element) => element.quantity >= element.targetQuantity);
    } else if (filter.showMarked == false) {
      filteredProducts.removeWhere((element) => element.marked == true);
    }

    switch (filter.sorting) {
      case ProductsSorting.name:
        filteredProducts.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ProductsSorting.update:
        filteredProducts.sort((a, b) => a.updated.isBefore(b.updated) ? -1 : 1);
        break;
      case ProductsSorting.quantity:
        filteredProducts.sort((a, b) => a.quantity.compareTo(b.quantity));
        break;
    }

    if (!filter.ascendingSorting) {
      filteredProducts = filteredProducts.reversed.toList();
    }

    //sortuje na góre oflagowane produkty
    filteredProducts.sort((a, b) => a.marked || !b.marked ? -1 : 1);

    return filteredProducts;
  }
}
