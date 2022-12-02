import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_app/models/models.dart';

import '../../repositories/sessions_repository.dart';
//import '../../repositories/settings_repository.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  final SessionsRepository sessionsRepository;
  //final SettingsRepository settingsRepository;
  late final StreamSubscription _subscription;

  SessionsCubit({
    required this.sessionsRepository,
    //required this.settingsRepository,
  }) : super(SessionsInitial()) {
    _subscribe();
    sessionsRepository.getSavedSessions();
  }

  List<Session> sessions = [];
  String? actualSessionId;

  Session? get actualSession => actualSessionId == null
      ? null
      : sessionsRepository.findById(actualSessionId!);

  void _subscribe() {
    _subscription = sessionsRepository.sessions.listen(
      (items) {
        sessions = items;

        emitSessions();
      },
      //TODO onError: (error) => emit(ListError('$error')),
    );
  }

  void emitSessions() {
    if (actualSessionId != null) {
      final actualSession = sessions.removeAt(
        sessions.indexWhere((session) => session.id == actualSessionId),
      );
      sessions.insert(0, actualSession);
    }
    emit(SessionsLoaded(
      sessions: sessions,
      actualSessionId: actualSessionId,
    ));
  }

  void createNewSession() async {
    //TODO dodać opcję ze nowa sesja nie zostaje automatycznie aktualną
    final Session actualSession = await sessionsRepository.createNewSession(
      //author: //settingsRepository.getSetting("author"),
      protectedId: actualSessionId,
    );
    actualSessionId = actualSession.id;
  }

  void restoreSession({required String id}) async {
    await sessionsRepository.restoreSession(id);
    actualSessionId = id;
    emitSessions();
  }

  void deleteSession({required String id}) async {
    //TODO sprawdzić czy działa dobrze - czy usuwa tez product&historySession
    if (actualSessionId != null && actualSessionId == id) {
      actualSessionId = null;
    }
    await sessionsRepository.deleteSession(id);
  }

  void endSession() async {
    if (actualSessionId != null) {
      final String endedId = actualSessionId!;
      actualSessionId = null;
      sessionsRepository.endSession(endedId);
    }
  }

  // void downloadSessionImages({String? id, required bool value}) async {
  //   if (id == null) {
  //     if (actualSessionId != null) {
  //       final updatedSession =
  //           actualSession!.copyWith(downloadImages: () => value);
  //       await sessionsRepository.updateSession(updatedSession);
  //     }
  //   } else {
  //     await sessionsRepository.updateSession(
  //       sessionsRepository.findById(id)!.copyWith(downloadImages: () => value),
  //     );
  //   }
  // }

  // void importSessionFromJson() async {
  //   await sessionsRepository.importSessionFromJson();
  // }

  // void exportSessionToJson({required String id}) async {
  //   await sessionsRepository.exportSessionToJson(id: id);
  // }

  // void importSessionFromHtmlTable(String data) async {
  //   await sessionsRepository.importSessionFromHtmlTable(
  //     author: settingsRepository.getSetting("author"),
  //     data: data,
  //   );
  // }

  // void importSessionFromCsv({
  //   required Map<String, int?> csvStructure,
  //   required List<List<String>> importedCsvList,
  // }) async {
  //   await sessionsRepository.importSessionFromCsv(
  //     author: settingsRepository.getSetting("author"),
  //     csvStructure: csvStructure,
  //     importedCsvList: importedCsvList,
  //   );
  // }

  // void exportSessionToCsv({required String id}) async {
  //   await sessionsRepository.exportSessionToCsv(id: id);
  // }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
