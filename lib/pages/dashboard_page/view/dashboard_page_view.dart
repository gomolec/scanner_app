import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/repositories.dart';
import '../../../routes/router.gr.dart';
import '../../../widgets/widgets.dart';
import '../bloc/dashboard_bloc.dart';
import 'widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        productsRepository: context.read<ProductsRepository>(),
        sessionsRepository: context.read<SessionsRepository>(),
      )..add(const DashboardSubscriptionRequested()),
      child: const DashboardPageView(),
    );
  }
}

class DashboardPageView extends StatelessWidget {
  const DashboardPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.actualSession != null) {
            return CustomScrollView(
              slivers: [
                SliverAppBar.medium(
                  title: const Text("Panel główny"),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings_rounded,
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        height: 1.0,
                        thickness: 1.0,
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Aktualna sesja użytkownika",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: state.actualSession != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DashboardCard(
                            sessionTitle: state.actualSession!.name,
                            sessionDate: state.actualSession!.startDate,
                            productsPositions: state.productsPositions,
                            productsProgress: state.productsProgress,
                            onTab: () {
                              context.router.push(const SessionsRouter());
                            },
                          ),
                        )
                      : const SizedBox(),
                ),
                SliverToBoxAdapter(
                  child: state.markedProducts.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "Zapisane produkty",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                SliverToBoxAdapter(
                  child: state.markedProducts.isNotEmpty
                      ? SizedBox(
                          height: 208.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: state.markedProducts.length,
                            itemBuilder: (context, index) => Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 16.0,
                                    left: index == 0 ? 16.0 : 0.0,
                                  ),
                                  child: MarkedProductsCard(
                                    product: state.markedProducts[index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Skróty",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const ShortcutButtons(),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                SafeArea(
                  child: AppBar(
                    title: const Text("Panel główny"),
                  ),
                ),
                PageAlert(
                  leadingIconData: Icons.folder_off_rounded,
                  title: "Brak aktywnej sesji",
                  text:
                      "\tPrzywróć poprzednio utworzoną sesję lub utwórz nową, do której możesz dodać produkty lub zaimportuj je z obsługiwanych plików.",
                  buttons: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.router.push(const SessionsRouter());
                      },
                      icon: const Icon(Icons.folder_copy),
                      label: const Text("Pokaż sesje użytkownika"),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
