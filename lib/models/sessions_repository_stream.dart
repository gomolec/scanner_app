import 'package:equatable/equatable.dart';

import 'models.dart';

class SessionsRepositoryStream extends Equatable {
  final String? actualSessionId;
  final List<Session> sessions;

  const SessionsRepositoryStream({
    this.actualSessionId,
    required this.sessions,
  });

  @override
  String toString() =>
      'SessionsRepositoryStream(actualSessionId: $actualSessionId, sessions: $sessions)';

  SessionsRepositoryStream copyWith({
    String? Function()? actualSessionId,
    List<Session>? sessions,
  }) {
    return SessionsRepositoryStream(
      actualSessionId:
          actualSessionId != null ? actualSessionId() : this.actualSessionId,
      sessions: sessions ?? this.sessions,
    );
  }

  @override
  List<Object?> get props => [actualSessionId, sessions];
}
