import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        DashboardRouter(),
        ProductsRouter(),
        DashboardRouter(),
        HistoryRouter(),
        MenuRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => NavigationBar(
        selectedIndex: tabsRouter.activeIndex,
        onDestinationSelected: (index) {
          if (index == 2) {
            context.router.push(ScannerRouter());
          } else {
            tabsRouter.setActiveIndex(index);
          }
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Start',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2_rounded),
            label: 'Produkty',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Skaner',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            label: 'Historia',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz_rounded),
            label: 'Więcej',
          ),
        ],
      ),
    );
  }
}
