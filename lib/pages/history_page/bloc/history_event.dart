part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistorySubscriptionRequested extends HistoryEvent {
  const HistorySubscriptionRequested();
}

class HistoryUndo extends HistoryEvent {
  const HistoryUndo();
}

class HistoryRedo extends HistoryEvent {
  const HistoryRedo();
}
