import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scanner_app/repositories/repositories.dart';
import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'routes/router.gr.dart';

void bootstrap() {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  final HiveInterface hiveInterface = Hive;

  late final ProductsRepository productsRepository =
      ProductsRepository(hiveInterface: hiveInterface);

  late final HistoryRepository historyRepository =
      HistoryRepository(hiveInterface: hiveInterface);

  late final SessionsRepository sessionsRepository = SessionsRepository(
    hiveInterface: hiveInterface,
    productsRepository: productsRepository,
    historyRepository: historyRepository,
  );

  final appRouter = AppRouter();

  runZonedGuarded(
    () => runApp(
      App(
        appRouter: appRouter,
        sessionsRepository: sessionsRepository,
        productsRepository: productsRepository,
        historyRepository: historyRepository,
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
