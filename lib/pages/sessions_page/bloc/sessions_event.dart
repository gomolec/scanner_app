part of 'sessions_bloc.dart';

abstract class SessionsEvent extends Equatable {
  const SessionsEvent();

  @override
  List<Object> get props => [];
}

class SessionsSubscriptionRequested extends SessionsEvent {
  const SessionsSubscriptionRequested();
}

class SessionCreated extends SessionsEvent {
  const SessionCreated({
    required this.name,
    required this.author,
    required this.note,
    required this.downloadUrls,
  });

  final String name;
  final String author;
  final String note;
  final bool downloadUrls;

  @override
  List<Object> get props => [name, author, note, downloadUrls];
}

class SessionDeleted extends SessionsEvent {
  const SessionDeleted({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

class SessionRestored extends SessionsEvent {
  const SessionRestored({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

class SessionEnded extends SessionsEvent {
  const SessionEnded({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}
