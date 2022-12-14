import 'dart:async';
import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../models/models.dart';

class HistoryRepository {
  final HiveInterface hiveInterface;
  final int maxStoredHistoryActions;

  HistoryRepository({
    required this.hiveInterface,
    this.maxStoredHistoryActions = 5,
  }) {
    _stream.sink.add(HistoryRepositoryStream(
      historyActions: _history,
      canUndo: false,
      canRedo: false,
    ));
  }

  Box<HistoryAction>? _historyBox;
  bool get isSessionOpened => _historyBox != null;
  List<HistoryAction> _history = [];
  int currentActivityIndex = -1;

  final _stream = BehaviorSubject<HistoryRepositoryStream>();
  Stream<HistoryRepositoryStream> get stream => _stream.stream;

  void addToStream(List<HistoryAction> historyActions) =>
      _stream.sink.add(_stream.value.copyWith(
        historyActions: historyActions,
        canRedo: canRedo(),
        canUndo: canUndo(),
      ));

  Future<void> openHistorySession(String id) async {
    if (_historyBox != null) {
      await closeHistorySession();
    }
    _historyBox = await Hive.openBox("stream-$id");
    _history = _historyBox!.values.toList();
    currentActivityIndex = -1;
    if (_history.isNotEmpty) {
      currentActivityIndex =
          _history.lastIndexWhere((element) => element.isRedo == false);
    }
    addToStream(_history);
  }

  Future<void> closeHistorySession() async {
    if (_historyBox != null) {
      await _historyBox!.close();
      _historyBox = null;
    }
    _history = [];
    addToStream(_history);
  }

  Future<void> deleteHistorySession(String id) async {
    if (_historyBox != null && _historyBox!.name == "stream-$id") {
      await closeHistorySession();
    }
    hiveInterface.deleteBoxFromDisk("stream-$id");
  }

  void addActivity({Product? oldProduct, Product? updatedProduct}) {
    if (oldProduct != updatedProduct) {
      int id = 0;
      if (currentActivityIndex > -1) {
        id = _history.last.id + 1;
      }
      currentActivityIndex++;
      if (_history.length > currentActivityIndex) {
        for (var i = _history.length - 1; i >= currentActivityIndex; i--) {
          _history.removeAt(i);
          _historyBox!.deleteAt(i);
        }
      }
      if (currentActivityIndex >= maxStoredHistoryActions) {
        _history.removeAt(0);
        _historyBox!.deleteAt(0);
        currentActivityIndex--;
      }
      final HistoryAction action = HistoryAction(
        id: id,
        oldProduct: oldProduct,
        updatedProduct: updatedProduct,
      );
      _history.add(action);
      _historyBox!.put(id, action);
      addToStream(_history);
    }
  }

  HistoryAction? undo() {
    if (_history.isNotEmpty && _history.first.isRedo == false) {
      log("$_history", name: "undo in repo");
      final HistoryAction action =
          _history[currentActivityIndex].copyWith(isRedo: true);
      _history[currentActivityIndex] = action;
      _historyBox!.put(action.id, action);
      currentActivityIndex--;
      addToStream(_history.toList());
      log("$_history", name: "undo in repo");
      return action;
    }
    return null;
  }

  HistoryAction? redo() {
    if (_history.isNotEmpty && _history.last.isRedo == true) {
      currentActivityIndex++;
      final HistoryAction action =
          _history[currentActivityIndex].copyWith(isRedo: false);
      _history[currentActivityIndex] = action;
      _historyBox!.put(action.id, action);
      addToStream(_history.toList());
      return action;
    }
    return null;
  }

  bool canUndo() {
    if (_history.isNotEmpty) {
      if (_history.first.isRedo == false) return true;
    }
    return false;
  }

  bool canRedo() {
    if (_history.isNotEmpty) {
      if (_history.last.isRedo == true) return true;
    }
    return false;
  }

  Future<void> importHistorySession({
    required String id,
    required List<HistoryAction> importedHistoryActions,
  }) async {
    final Box<HistoryAction> importedHistoryBox =
        await hiveInterface.openBox("stream-$id");

    importedHistoryBox.addAll(importedHistoryActions);

    importedHistoryBox.close();
  }

  Future<List<HistoryAction>> exportHistorySession({required String id}) async {
    final Box<HistoryAction> exportedHistoryBox =
        await hiveInterface.openBox("stream-$id");

    final List<HistoryAction> exportedHistoryActions =
        exportedHistoryBox.values.toList();

    exportedHistoryBox.close();

    return exportedHistoryActions;
  }
}
