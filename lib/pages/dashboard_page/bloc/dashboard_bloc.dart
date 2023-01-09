import 'package:collection/collection.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required SessionsRepository sessionsRepository,
    required ProductsRepository productsRepository,
  })  : _sessionsRepository = sessionsRepository,
        _productsRepository = productsRepository,
        super(const DashboardState()) {
    on<DashboardSubscriptionRequested>(_subscriptionRequested);
  }

  final SessionsRepository _sessionsRepository;
  final ProductsRepository _productsRepository;

  Future<void> _subscriptionRequested(
    DashboardSubscriptionRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));

    final stream = StreamGroup.mergeBroadcast(
        [_sessionsRepository.stream, _productsRepository.stream]);

    await emit.forEach(
      stream,
      onData: (data) {
        if (data is SessionsRepositoryStream) {
          Session? actualSession;
          if (data.actualSessionId != null &&
              data.actualSessionId != (state.actualSession?.id ?? "")) {
            actualSession = data.sessions
                .firstWhereOrNull((it) => it.id == data.actualSessionId);
          }
          return state.copyWith(
            status: DashboardStatus.success,
            actualSession: () => actualSession,
          );
        } else if (data is List<Product>) {
          if (_productsRepository.isSessionOpened) {
            int productsPositions = data.length;
            int productsProgress = 0;
            List<Product> markedProducts = [];
            if (productsPositions > 0) {
              markedProducts =
                  data.where((element) => element.marked == true).toList();
              int completedProducts = data
                  .where(
                      (element) => element.quantity >= element.targetQuantity)
                  .length;
              productsProgress =
                  (completedProducts * 100 / productsPositions).round();
            }
            return state.copyWith(
              productsPositions: productsPositions,
              productsProgress: productsProgress,
              markedProducts: markedProducts,
            );
          }
          return state;
        }
        return state;
      },
      onError: (_, __) => state.copyWith(
        status: DashboardStatus.failure,
      ),
    );
  }
}
