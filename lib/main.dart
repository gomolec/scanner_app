import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cubits/cubits.dart';
import 'models/models.dart';
import 'repositories/repositories.dart';
import 'routes/router.gr.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(HistoryActionAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SessionsCubit(
            sessionsRepository: sessionsRepository,
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ProductsCubit(
            productsRepository: productsRepository,
            historyRepository: historyRepository,
          ),
          lazy: false,
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
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
