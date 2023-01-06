import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({
    required HistoryRepository historyRepository,
    required ProductsHistoryRepository productsHistoryRepository,
  })  : _historyRepository = historyRepository,
        _productsHistoryRepository = productsHistoryRepository,
        super(const HistoryState()) {
    on<HistorySubscriptionRequested>(_onSubscriptionRequested);
    on<HistoryUndo>(_onUndo);
    on<HistoryRedo>(_onRedo);
  }

  final HistoryRepository _historyRepository;
  final ProductsHistoryRepository _productsHistoryRepository;

  Future<void> _onSubscriptionRequested(
    HistorySubscriptionRequested event,
    Emitter<HistoryState> emit,
  ) async {
    if (_historyRepository.isSessionOpened) {
      emit(state.copyWith(status: () => HistoryStatus.loading));
    }

    await emit.forEach(
      _historyRepository.stream,
      onData: (data) {
        List<HistoryAction> undoHistory = data.historyActions;
        undoHistory.removeWhere((element) => element.isRedo == true);

        if (undoHistory.isEmpty && !_historyRepository.isSessionOpened) {
          return state.copyWith(
            status: () => HistoryStatus.initial,
            history: () => undoHistory.toList(),
            canUndo: () => data.canUndo,
            canRedo: () => data.canRedo,
          );
        }
        return state.copyWith(
          status: () => HistoryStatus.success,
          history: () => undoHistory.toList(),
          canUndo: () => data.canUndo,
          canRedo: () => data.canRedo,
        );
      },
      onError: (_, __) {
        return state.copyWith(
          status: () => HistoryStatus.failure,
        );
      },
    );
  }

  void _onUndo(
    HistoryUndo event,
    Emitter<HistoryState> emit,
  ) {
    _productsHistoryRepository.undo();
  }

  void _onRedo(
    HistoryRedo event,
    Emitter<HistoryState> emit,
  ) {
    log("history bloc - redo");
    _productsHistoryRepository.redo();
  }
}
