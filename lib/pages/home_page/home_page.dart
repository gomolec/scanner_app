import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Start',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.boxesStacked),
            label: 'Produkty',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.barcode),
            label: 'Skaner',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.clockRotateLeft),
            label: 'Historia',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.ellipsis),
            label: 'Więcej',
          ),
        ],
      ),
    );
  }
}
