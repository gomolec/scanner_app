import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/repositories.dart';
import '../routes/router.gr.dart';
import '../theme/theme.dart';

class App extends StatelessWidget {
  final SessionsRepository sessionsRepository;
  final ProductsRepository productsRepository;
  final HistoryRepository historyRepository;
  final ProductsHistoryRepository productsHistoryRepository;
  final AppRouter appRouter;

  const App({
    Key? key,
    required this.sessionsRepository,
    required this.productsRepository,
    required this.historyRepository,
    required this.productsHistoryRepository,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: sessionsRepository,
        ),
        RepositoryProvider.value(
          value: productsRepository,
        ),
        RepositoryProvider.value(
          value: historyRepository,
        ),
        RepositoryProvider.value(
          value: productsHistoryRepository,
        ),
      ],
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          ColorScheme lightScheme;
          ColorScheme darkScheme;

          if (lightDynamic != null && darkDynamic != null) {
            lightScheme = lightDynamic.harmonized();
            lightCustomColors = lightCustomColors.harmonized(lightScheme);

            darkScheme = darkDynamic.harmonized();
            darkCustomColors = darkCustomColors.harmonized(darkScheme);
          } else {
            lightScheme = lightColorScheme;
            darkScheme = darkColorScheme;
          }

          return MaterialApp.router(
            title: 'Scanner App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightScheme,
              extensions: [lightCustomColors],
            ).copyWith(
              popupMenuTheme: PopupMenuThemeData(
                color: lightScheme.surfaceVariant,
                elevation: 3,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkScheme,
              extensions: [darkCustomColors],
            ).copyWith(
              popupMenuTheme: PopupMenuThemeData(
                color: darkScheme.surfaceVariant,
                elevation: 3,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
