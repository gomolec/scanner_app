part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final Session? actualSession;
  final int productsPositions;
  final int productsProgress;
  final List<Product> markedProducts;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.actualSession,
    this.productsPositions = 0,
    this.productsProgress = 0,
    this.markedProducts = const [],
  });

  @override
  List<Object?> get props {
    return [
      status,
      actualSession,
      productsPositions,
      productsProgress,
      markedProducts,
    ];
  }

  @override
  String toString() {
    return 'DashboardState(status: $status, actualSession: $actualSession, productsPositions: $productsPositions, productsProgress: $productsProgress, markedProducts: $markedProducts)';
  }

  DashboardState copyWith({
    DashboardStatus? status,
    Session? Function()? actualSession,
    int? productsPositions,
    int? productsProgress,
    List<Product>? markedProducts,
  }) {
    return DashboardState(
      status: status ?? this.status,
      actualSession:
          actualSession != null ? actualSession() : this.actualSession,
      productsPositions: productsPositions ?? this.productsPositions,
      productsProgress: productsProgress ?? this.productsProgress,
      markedProducts: markedProducts ?? this.markedProducts,
    );
  }
}
