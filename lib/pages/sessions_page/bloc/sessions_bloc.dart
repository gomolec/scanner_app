import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_app/models/models.dart';
import 'package:scanner_app/models/sessions_repository_stream.dart';
import 'package:scanner_app/repositories/repositories.dart';

part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  SessionsBloc({
    required SessionsRepository sessionsRepository,
  })  : _sessionsRepository = sessionsRepository,
        super(const SessionsState()) {
    on<SessionsSubscriptionRequested>(_onSubscriptionRequested);
    on<SessionCreated>(_onSessionCreated);
    on<SessionDeleted>(_onSessionDeleted);
    on<SessionRestored>(_onSessionRestored);
    on<SessionEnded>(_onSessionEnded);
  }

  final SessionsRepository _sessionsRepository;

  Future<void> _onSubscriptionRequested(
    SessionsSubscriptionRequested event,
    Emitter<SessionsState> emit,
  ) async {
    emit(state.copyWith(status: () => SessionsStatus.loading));

    await emit.forEach<SessionsRepositoryStream>(
      _sessionsRepository.stream,
      onData: (data) {
        List<Session> sessions = data.sessions;

        if (data.actualSessionId != null) {
          final index =
              sessions.indexWhere((it) => it.id == data.actualSessionId);
          sessions.insert(0, sessions.removeAt(index));
        }
        return state.copyWith(
          status: () => SessionsStatus.success,
          isActualSession: () => data.actualSessionId != null,
          sessions: () => sessions,
        );
      },
      onError: (_, __) => state.copyWith(
        status: () => SessionsStatus.failure,
      ),
    );
  }

  void _onSessionCreated(
    SessionCreated event,
    Emitter<SessionsState> emit,
  ) {
    _sessionsRepository.createNewSession(
      name: event.name,
      author: event.author,
      note: event.note,
      downloadUrls: event.downloadUrls,
    );
  }

  void _onSessionDeleted(
    SessionDeleted event,
    Emitter<SessionsState> emit,
  ) {
    _sessionsRepository.deleteSession(event.id);
  }

  void _onSessionRestored(
    SessionRestored event,
    Emitter<SessionsState> emit,
  ) {
    _sessionsRepository.restoreSession(event.id);
  }

  void _onSessionEnded(
    SessionEnded event,
    Emitter<SessionsState> emit,
  ) {
    _sessionsRepository.endSession(event.id);
  }
}
