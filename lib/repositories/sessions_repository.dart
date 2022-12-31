import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scanner_app/models/sessions_repository_stream.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';
import 'history_repository.dart';
import 'products_repository.dart';

class SessionsRepository {
  final HiveInterface hiveInterface;
  final int maxStoredSessions;

  final ProductsRepository productsRepository;
  final HistoryRepository historyRepository;

  SessionsRepository({
    required this.hiveInterface,
    this.maxStoredSessions = 8,
    required this.productsRepository,
    required this.historyRepository,
  }) {
    addToStream(const SessionsRepositoryStream(
      actualSessionId: null,
      sessions: [],
    ));
    getSavedSessions();
  }

  Box<Session>? _sessionsBox;

  final _stream = BehaviorSubject<SessionsRepositoryStream>();
  Stream<SessionsRepositoryStream> get stream => _stream.stream;

  void addToStream(SessionsRepositoryStream value) => _stream.sink.add(value);

  Future<Session> createNewSession({
    String? name,
    String? author,
    String? note,
    bool? downloadUrls,
  }) async {
    final newSession = Session(
      id: const Uuid().v1(),
      startDate: DateTime.now(),
      name: name ?? "",
      author: author ?? "",
      note: note ?? "",
      downloadUrls: downloadUrls ?? false,
    );
    if (_sessionsBox!.length >= maxStoredSessions) {
      Session deletedSession = _sessionsBox!.values.toList()[0];
      if (deletedSession.id == _stream.value.actualSessionId) {
        deletedSession = _sessionsBox!.values.toList()[1];
      }
      await deleteSession(deletedSession.id, notify: false);
    }
    await _sessionsBox!.add(newSession);
    await productsRepository.openProductsSession(newSession.id);
    await historyRepository.openHistorySession(newSession.id);
    addToStream(
      _stream.value.copyWith(
        sessions: _sessionsBox!.values.toList(),
      ),
    );
    return newSession;
  }

  Future<void> getSavedSessions() async {
    _sessionsBox = await hiveInterface.openBox('sessions');
    addToStream(
      _stream.value.copyWith(
        sessions: _sessionsBox!.values.toList(),
      ),
    );
  }

  Session? findById(String id) {
    if (_sessionsBox == null) return null;
    return _sessionsBox!.values
        .toList()
        .cast<Session?>()
        .firstWhere((session) => session!.id == id, orElse: () => null);
  }

  Future<void> deleteSession(String id, {bool notify = true}) async {
    final index = _sessionsBox!.values.toList().indexWhere((it) => it.id == id);
    if (index != -1) {
      await _sessionsBox!.delete(_sessionsBox!.keys.toList()[index]);
      if (notify) {
        if (id == _stream.value.actualSessionId) {
          addToStream(
            _stream.value.copyWith(
              actualSessionId: () => null,
              sessions: _sessionsBox!.values.toList(),
            ),
          );
        } else {
          addToStream(
            _stream.value.copyWith(
              sessions: _sessionsBox!.values.toList(),
            ),
          );
        }
      }
      await productsRepository.deleteProductsSession(id);
      await historyRepository.deleteHistorySession(id);
    }
  }

  Future<void> updateSession(Session session, {bool notify = true}) async {
    final index =
        _sessionsBox!.values.toList().indexWhere((it) => it.id == session.id);
    if (index != -1) {
      await _sessionsBox!.put(_sessionsBox!.keys.toList()[index], session);
      if (notify) {
        addToStream(
          _stream.value.copyWith(
            sessions: _sessionsBox!.values.toList(),
          ),
        );
      }
    }
  }

  Future<void> endSession(String id) async {
    Session? session = findById(id);
    if (session != null) {
      session = session.copyWith(endDate: () => DateTime.now());
      updateSession(session, notify: false);
      addToStream(
        _stream.value.copyWith(
          actualSessionId: () => null,
          sessions: _sessionsBox!.values.toList(),
        ),
      );
      await productsRepository.closeProductsSession();
      await historyRepository.closeHistorySession();
    }
  }

  Future<Session?> restoreSession(String id) async {
    Session? session = findById(id);
    if (session != null) {
      session = session.copyWith(endDate: () => null);
      updateSession(session, notify: false);
      await productsRepository.openProductsSession(id);
      await historyRepository.openHistorySession(id);
    }
    addToStream(
      _stream.value.copyWith(
        actualSessionId: () => id,
        sessions: _sessionsBox!.values.toList(),
      ),
    );
    return session;
  }

  // Future<void> importSessionFromJson() async {
  //   final Map? importedSessionData =
  //       await ImportService().importSessionFromJson();

  //   if (importedSessionData != null) {
  //     await _sessionsBox!.add(importedSessionData["session"]);

  //     await productsRepository.importProductsSession(
  //       id: importedSessionData["session"].id,
  //       importedProducts: importedSessionData["products"],
  //     );

  //     await historyRepository.importHistorySession(
  //       id: importedSessionData["session"].id,
  //       importedHistoryActions: importedSessionData["historyActions"],
  //     );

  //     addToSessionsStream(_sessionsBox!.values.toList());
  //   }
  // }

  // Future<void> exportSessionToJson({required String id}) async {
  //   final Session? exportedSession = findById(id);

  //   if (exportedSession != null) {
  //     await ExportService().exportSessionToJson(
  //       session: exportedSession,
  //       products: await productsRepository.exportProductsSession(id: id),
  //       historyActions: await historyRepository.exportHistorySession(id: id),
  //     );
  //   }
  // }

  // Future<void> importSessionFromHtmlTable({
  //   String? author,
  //   required String data,
  // }) async {
  //   final Map<int, Product>? importedProductsData =
  //       await ImportService().importFromHtmlTable(data);

  //   if (importedProductsData != null) {
  //     final newSession = Session(
  //       id: const Uuid().v1(),
  //       startDate: DateTime.now(),
  //       author: author,
  //     );
  //     if (_sessionsBox!.length >= maxStoredSessions) {
  //       await deleteSession(_sessionsBox!.values.toList().first.id);
  //     }
  //     await _sessionsBox!.add(newSession);

  //     await productsRepository.importProductsSession(
  //       id: newSession.id,
  //       importedProducts: importedProductsData,
  //     );

  //     await historyRepository.importHistorySession(
  //       id: newSession.id,
  //       importedHistoryActions: [],
  //     );

  //     addToSessionsStream(_sessionsBox!.values.toList());
  //   }
  // }

  // Future<void> importSessionFromCsv({
  //   String? author,
  //   required Map<String, int?> csvStructure,
  //   required List<List<String>> importedCsvList,
  // }) async {
  //   final Map<int, Product>? importedProductsData =
  //       await ImportService().importFromCsv(
  //     csvStructure: csvStructure,
  //     importedCsvList: importedCsvList,
  //   );

  //   if (importedProductsData != null) {
  //     final newSession = Session(
  //       id: const Uuid().v1(),
  //       startDate: DateTime.now(),
  //       author: author,
  //     );
  //     if (_sessionsBox!.length >= maxStoredSessions) {
  //       await deleteSession(_sessionsBox!.values.toList().first.id);
  //     }
  //     await _sessionsBox!.add(newSession);

  //     await productsRepository.importProductsSession(
  //       id: newSession.id,
  //       importedProducts: importedProductsData,
  //       generateNewIds: true,
  //     );

  //     await historyRepository.importHistorySession(
  //       id: newSession.id,
  //       importedHistoryActions: [],
  //     );

  //     addToSessionsStream(_sessionsBox!.values.toList());
  //   }
  // }

  // Future<void> exportSessionToCsv({required String id}) async {
  //   final Session? exportedSession = findById(id);

  //   if (exportedSession != null) {
  //     await ExportService().exportToCsv(
  //       session: exportedSession,
  //       products: await productsRepository.exportProductsSession(id: id),
  //     );
  //   }
  // }
}
