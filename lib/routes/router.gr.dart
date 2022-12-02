// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/cupertino.dart' as _i4;
import 'package:flutter/material.dart' as _i3;

import '../pages/pages.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    ScannerRouter.name: (routeData) {
      final args = routeData.argsAs<ScannerRouterArgs>(
          orElse: () => const ScannerRouterArgs());
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.ScannerPage(key: args.key),
      );
    },
    SessionsRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SessionsPage(),
      );
    },
    DashboardRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    ProductsRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsPage(),
      );
    },
    HistoryRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HistoryPage(),
      );
    },
    MenuRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MenuPage(),
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i2.RouteConfig(
              DashboardRouter.name,
              path: 'dashboard',
              parent: HomeRoute.name,
            ),
            _i2.RouteConfig(
              ProductsRouter.name,
              path: 'products',
              parent: HomeRoute.name,
            ),
            _i2.RouteConfig(
              ScannerRouter.name,
              path: 'scanner',
              parent: HomeRoute.name,
            ),
            _i2.RouteConfig(
              HistoryRouter.name,
              path: 'history',
              parent: HomeRoute.name,
            ),
            _i2.RouteConfig(
              MenuRouter.name,
              path: 'menu',
              parent: HomeRoute.name,
            ),
          ],
        ),
        _i2.RouteConfig(
          ScannerRouter.name,
          path: 'scanner',
        ),
        _i2.RouteConfig(
          SessionsRouter.name,
          path: 'sessions',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.ScannerPage]
class ScannerRouter extends _i2.PageRouteInfo<ScannerRouterArgs> {
  ScannerRouter({_i4.Key? key})
      : super(
          ScannerRouter.name,
          path: 'scanner',
          args: ScannerRouterArgs(key: key),
        );

  static const String name = 'ScannerRouter';
}

class ScannerRouterArgs {
  const ScannerRouterArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'ScannerRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.SessionsPage]
class SessionsRouter extends _i2.PageRouteInfo<void> {
  const SessionsRouter()
      : super(
          SessionsRouter.name,
          path: 'sessions',
        );

  static const String name = 'SessionsRouter';
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRouter extends _i2.PageRouteInfo<void> {
  const DashboardRouter()
      : super(
          DashboardRouter.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRouter';
}

/// generated route for
/// [_i1.ProductsPage]
class ProductsRouter extends _i2.PageRouteInfo<void> {
  const ProductsRouter()
      : super(
          ProductsRouter.name,
          path: 'products',
        );

  static const String name = 'ProductsRouter';
}

/// generated route for
/// [_i1.HistoryPage]
class HistoryRouter extends _i2.PageRouteInfo<void> {
  const HistoryRouter()
      : super(
          HistoryRouter.name,
          path: 'history',
        );

  static const String name = 'HistoryRouter';
}

/// generated route for
/// [_i1.MenuPage]
class MenuRouter extends _i2.PageRouteInfo<void> {
  const MenuRouter()
      : super(
          MenuRouter.name,
          path: 'menu',
        );

  static const String name = 'MenuRouter';
}
