import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'new_session_event.dart';
part 'new_session_state.dart';

class NewSessionBloc extends Bloc<NewSessionEvent, NewSessionState> {
  NewSessionBloc({
    required SessionsRepository sessionsRepository,
    required String? initialSessionId,
  })  : _sessionsRepository = sessionsRepository,
        _initialSession = initialSessionId != null
            ? sessionsRepository.findById(initialSessionId)
            : null,
        super(
          const NewSessionState(status: NewSessionStatus.loading),
        ) {
    on<NewSessionSubscriptionRequested>(_newSessionSubscriptionRequested);
    on<NewSessionNameChanged>(_newSessionNameChanged);
    on<NewSessionNoteChanged>(_newSessionNoteChanged);
    on<NewSessionAuthorChanged>(_newSessionAuthorChanged);
    on<NewSessionDownloadUrlsChanged>(_newSessionDownloadUrlsChanged);
    on<NewSessionSubmitted>(_newSessionSubmitted);
  }

  final SessionsRepository _sessionsRepository;
  final Session? _initialSession;

  void _newSessionSubscriptionRequested(
    NewSessionSubscriptionRequested event,
    Emitter<NewSessionState> emit,
  ) {
    emit(state.copyWith(
      status: NewSessionStatus.initial,
      initialSession: _initialSession,
      name: _initialSession?.name ?? '',
      note: _initialSession?.note ?? '',
      //TODO powinno pobierać z ustawień
      author: _initialSession?.author ?? '',
      //TODO powinno pobierać z ustawień
      downloadUrls: _initialSession?.downloadUrls ?? false,
    ));
  }

  void _newSessionNameChanged(
    NewSessionNameChanged event,
    Emitter<NewSessionState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _newSessionNoteChanged(
    NewSessionNoteChanged event,
    Emitter<NewSessionState> emit,
  ) {
    emit(state.copyWith(note: event.note));
  }

  void _newSessionAuthorChanged(
    NewSessionAuthorChanged event,
    Emitter<NewSessionState> emit,
  ) {
    emit(state.copyWith(author: event.author));
  }

  void _newSessionDownloadUrlsChanged(
    NewSessionDownloadUrlsChanged event,
    Emitter<NewSessionState> emit,
  ) {
    emit(state.copyWith(downloadUrls: event.downloadUrls));
  }

  Future<void> _newSessionSubmitted(
    NewSessionSubmitted event,
    Emitter<NewSessionState> emit,
  ) async {
    emit(state.copyWith(status: NewSessionStatus.loading));

    final Session session =
        (state.initialSession ?? Session(id: "", startDate: DateTime.now()))
            .copyWith(
      name: state.name,
      note: state.note,
      author: state.author,
      downloadUrls: state.downloadUrls,
    );

    try {
      if (state.isNewSession) {
        await _sessionsRepository.createNewSession(
          name: session.name,
          note: session.note,
          author: session.author,
          downloadUrls: session.downloadUrls,
        );
      } else {
        await _sessionsRepository.updateSession(session);
      }

      emit(state.copyWith(status: NewSessionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NewSessionStatus.failure));
    }
  }
}
