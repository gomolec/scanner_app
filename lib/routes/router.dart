import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
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
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          page: SessionsPage,
        ),
        AutoRoute(
          path: 'new',
          name: 'NewSessionRouter',
          page: NewSessionPage,
        )
      ],
    ),
    AutoRoute(
      name: 'SingleProductRouter',
      path: 'product/:productId',
      page: SingleProductPage,
    ),
  ],
)
class $AppRouter {}
