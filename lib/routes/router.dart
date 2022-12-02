import 'package:auto_route/auto_route.dart';
import '../pages/pages.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomePage,
      children: [
        AutoRoute(
          path: 'dashboard',
          name: 'DashboardRouter',
          page: DashboardPage,
        ),
        AutoRoute(
          path: 'products',
          name: 'ProductsRouter',
          page: ProductsPage,
        ),
        AutoRoute(
          path: 'scanner',
          name: 'ScannerRouter',
          page: ScannerPage,
        ),
        AutoRoute(
          path: 'history',
          name: 'HistoryRouter',
          page: HistoryPage,
        ),
        AutoRoute(
          path: 'menu',
          name: 'MenuRouter',
          page: MenuPage,
        )
      ],
    ),
    AutoRoute(
      path: 'scanner',
      name: 'ScannerRouter',
      page: ScannerPage,
    ),
    AutoRoute(
      path: 'sessions',
      name: 'SessionsRouter',
      page: SessionsPage,
    ),
  ],
)
class $AppRouter {}
