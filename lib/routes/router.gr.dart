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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:auto_route/empty_router_widgets.dart' as _i2;
import 'package:flutter/cupertino.dart' as _i5;
import 'package:flutter/material.dart' as _i4;

import '../pages/pages.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    ScannerRouter.name: (routeData) {
      final args = routeData.argsAs<ScannerRouterArgs>(
          orElse: () => const ScannerRouterArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.ScannerPage(key: args.key),
      );
    },
    SessionsRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    SingleProductRouter.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleProductRouterArgs>(
          orElse: () => SingleProductRouterArgs(
              productId: pathParams.getInt('productId')));
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.SingleProductPage(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    DashboardRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    ProductsRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ProductsPage(),
      );
    },
    HistoryRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HistoryPage(),
      );
    },
    MenuRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MenuPage(),
      );
    },
    SessionsRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SessionsPage(),
      );
    },
    NewSessionRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NewSessionPage(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            _i3.RouteConfig(
              DashboardRouter.name,
              path: 'dashboard',
              parent: HomeRoute.name,
            ),
            _i3.RouteConfig(
              ProductsRouter.name,
              path: 'products',
              parent: HomeRoute.name,
            ),
            _i3.RouteConfig(
              ScannerRouter.name,
              path: 'scanner',
              parent: HomeRoute.name,
            ),
            _i3.RouteConfig(
              HistoryRouter.name,
              path: 'history',
              parent: HomeRoute.name,
            ),
            _i3.RouteConfig(
              MenuRouter.name,
              path: 'menu',
              parent: HomeRoute.name,
            ),
          ],
        ),
        _i3.RouteConfig(
          ScannerRouter.name,
          path: 'scanner',
        ),
        _i3.RouteConfig(
          SessionsRouter.name,
          path: 'sessions',
          children: [
            _i3.RouteConfig(
              SessionsRoute.name,
              path: '',
              parent: SessionsRouter.name,
            ),
            _i3.RouteConfig(
              NewSessionRouter.name,
              path: 'new',
              parent: SessionsRouter.name,
            ),
          ],
        ),
        _i3.RouteConfig(
          SingleProductRouter.name,
          path: 'product/:productId',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.ScannerPage]
class ScannerRouter extends _i3.PageRouteInfo<ScannerRouterArgs> {
  ScannerRouter({_i5.Key? key})
      : super(
          ScannerRouter.name,
          path: 'scanner',
          args: ScannerRouterArgs(key: key),
        );

  static const String name = 'ScannerRouter';
}

class ScannerRouterArgs {
  const ScannerRouterArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'ScannerRouterArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.EmptyRouterPage]
class SessionsRouter extends _i3.PageRouteInfo<void> {
  const SessionsRouter({List<_i3.PageRouteInfo>? children})
      : super(
          SessionsRouter.name,
          path: 'sessions',
          initialChildren: children,
        );

  static const String name = 'SessionsRouter';
}

/// generated route for
/// [_i1.SingleProductPage]
class SingleProductRouter extends _i3.PageRouteInfo<SingleProductRouterArgs> {
  SingleProductRouter({
    _i5.Key? key,
    required int productId,
  }) : super(
          SingleProductRouter.name,
          path: 'product/:productId',
          args: SingleProductRouterArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'productId': productId},
        );

  static const String name = 'SingleProductRouter';
}

class SingleProductRouterArgs {
  const SingleProductRouterArgs({
    this.key,
    required this.productId,
  });

  final _i5.Key? key;

  final int productId;

  @override
  String toString() {
    return 'SingleProductRouterArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRouter extends _i3.PageRouteInfo<void> {
  const DashboardRouter()
      : super(
          DashboardRouter.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRouter';
}

/// generated route for
/// [_i1.ProductsPage]
class ProductsRouter extends _i3.PageRouteInfo<void> {
  const ProductsRouter()
      : super(
          ProductsRouter.name,
          path: 'products',
        );

  static const String name = 'ProductsRouter';
}

/// generated route for
/// [_i1.HistoryPage]
class HistoryRouter extends _i3.PageRouteInfo<void> {
  const HistoryRouter()
      : super(
          HistoryRouter.name,
          path: 'history',
        );

  static const String name = 'HistoryRouter';
}

/// generated route for
/// [_i1.MenuPage]
class MenuRouter extends _i3.PageRouteInfo<void> {
  const MenuRouter()
      : super(
          MenuRouter.name,
          path: 'menu',
        );

  static const String name = 'MenuRouter';
}

/// generated route for
/// [_i1.SessionsPage]
class SessionsRoute extends _i3.PageRouteInfo<void> {
  const SessionsRoute()
      : super(
          SessionsRoute.name,
          path: '',
        );

  static const String name = 'SessionsRoute';
}

/// generated route for
/// [_i1.NewSessionPage]
class NewSessionRouter extends _i3.PageRouteInfo<void> {
  const NewSessionRouter()
      : super(
          NewSessionRouter.name,
          path: 'new',
        );

  static const String name = 'NewSessionRouter';
}
