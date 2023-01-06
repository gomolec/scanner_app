import 'package:equatable/equatable.dart';

import 'package:scanner_app/models/models.dart';

class HistoryRepositoryStream extends Equatable {
  final List<HistoryAction> historyActions;
  final bool canUndo;
  final bool canRedo;

  const HistoryRepositoryStream({
    required this.historyActions,
    required this.canUndo,
    required this.canRedo,
  });

  HistoryRepositoryStream copyWith({
    List<HistoryAction>? historyActions,
    bool? canUndo,
    bool? canRedo,
  }) {
    return HistoryRepositoryStream(
      historyActions: historyActions ?? this.historyActions,
      canUndo: canUndo ?? this.canUndo,
      canRedo: canRedo ?? this.canRedo,
    );
  }

  @override
  String toString() =>
      'HistoryRepositoryStream(historyActions: $historyActions, canUndo: $canUndo, canRedo: $canRedo)';

  @override
  List<Object> get props => [historyActions, canUndo, canRedo];
}
