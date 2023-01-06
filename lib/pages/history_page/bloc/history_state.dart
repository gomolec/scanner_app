part of 'history_bloc.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final List<HistoryAction> history;
  final bool canUndo;
  final bool canRedo;

  const HistoryState({
    this.status = HistoryStatus.initial,
    this.history = const [],
    this.canUndo = false,
    this.canRedo = false,
  });

  @override
  List<Object> get props => [status, history, canUndo, canRedo];

  HistoryState copyWith({
    HistoryStatus Function()? status,
    List<HistoryAction> Function()? history,
    bool Function()? canUndo,
    bool Function()? canRedo,
  }) {
    return HistoryState(
      status: status != null ? status() : this.status,
      history: history != null ? history() : this.history,
      canUndo: canUndo != null ? canUndo() : this.canUndo,
      canRedo: canRedo != null ? canRedo() : this.canRedo,
    );
  }

  @override
  String toString() {
    return 'HistoryState(status: $status, history: $history, canUndo: $canUndo, canRedo: $canRedo)';
  }
}
