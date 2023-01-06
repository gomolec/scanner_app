import 'dart:developer';

import '../models/models.dart';
import 'repositories.dart';

class ProductsHistoryRepository {
  final ProductsRepository productsRepository;
  final HistoryRepository historyRepository;

  ProductsHistoryRepository({
    required this.productsRepository,
    required this.historyRepository,
  });

  void addProduct(Product product) {
    final Product createdProduct = productsRepository.addProduct(product);
    historyRepository.addActivity(
      updatedProduct: createdProduct,
    );
  }

  void deleteProduct(Product product) {
    final Product? deletedProduct = productsRepository.deleteProduct(product);
    if (deletedProduct != null) {
      historyRepository.addActivity(
        oldProduct: deletedProduct,
      );
    }
  }

  void updateProduct(Product product, {bool changeUpdated = true}) {
    final Product? oldProduct = productsRepository.findById(product.id);
    final Product? updatedProduct = productsRepository.updateProduct(
      product,
      changeUpdated: changeUpdated,
    );
    if (oldProduct != null && updatedProduct != null) {
      historyRepository.addActivity(
        oldProduct: oldProduct,
        updatedProduct: updatedProduct,
      );
    }
  }

  void undo() {
    final HistoryAction? undoAction = historyRepository.undo();
    if (undoAction != null) {
      if (undoAction.oldProduct == null && undoAction.updatedProduct != null) {
        productsRepository.deleteProduct(undoAction.updatedProduct!);
      } else if (undoAction.oldProduct != null &&
          undoAction.updatedProduct == null) {
        productsRepository.addProduct(undoAction.oldProduct!);
      } else {
        productsRepository.updateProduct(undoAction.oldProduct!);
      }
    }
  }

  void redo() {
    final HistoryAction? redoAction = historyRepository.redo();
    log("products history repo $redoAction");
    if (redoAction != null) {
      if (redoAction.oldProduct == null && redoAction.updatedProduct != null) {
        log("dodawanie");
        productsRepository.addProduct(redoAction.updatedProduct!);
      } else if (redoAction.oldProduct != null &&
          redoAction.updatedProduct == null) {
        log("usuwanie");
        productsRepository.deleteProduct(redoAction.oldProduct!);
      } else {
        log("przywracanie");
        productsRepository.updateProduct(redoAction.updatedProduct!);
      }
    }
  }
}
