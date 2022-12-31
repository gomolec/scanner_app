part of 'sessions_bloc.dart';

enum SessionsStatus { initial, loading, success, failure }

class SessionsState extends Equatable {
  final SessionsStatus status;
  final bool isActualSession;
  final List<Session> sessions;

  const SessionsState({
    this.status = SessionsStatus.initial,
    this.isActualSession = false,
    this.sessions = const [],
  });

  @override
  List<Object?> get props => [status, isActualSession, sessions];

  SessionsState copyWith({
    SessionsStatus Function()? status,
    bool Function()? isActualSession,
    List<Session> Function()? sessions,
  }) {
    return SessionsState(
      status: status != null ? status() : this.status,
      isActualSession:
          isActualSession != null ? isActualSession() : this.isActualSession,
      sessions: sessions != null ? sessions() : this.sessions,
    );
  }

  @override
  String toString() =>
      '\nSessionsState(status: $status, \nactualSession: $isActualSession, \nsessions: $sessions)';
}
