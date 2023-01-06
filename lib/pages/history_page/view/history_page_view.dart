import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/repositories.dart';
import '../../../routes/router.gr.dart';
import '../../../widgets/widgets.dart';
import '../bloc/history_bloc.dart';
import 'widgets/widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(
        historyRepository: context.read<HistoryRepository>(),
        productsHistoryRepository: context.read<ProductsHistoryRepository>(),
      )..add(const HistorySubscriptionRequested()),
      child: const HistoryPageView(),
    );
  }
}

class HistoryPageView extends StatelessWidget {
  const HistoryPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar.medium(
                title: const Text("Historia"),
                actions: [
                  IconButton(
                    onPressed: state.canUndo
                        ? () {
                            context
                                .read<HistoryBloc>()
                                .add(const HistoryUndo());
                          }
                        : null,
                    tooltip: "Cofnij",
                    icon: const Icon(Icons.undo_rounded),
                  ),
                  IconButton(
                    onPressed: state.canRedo
                        ? () {
                            context
                                .read<HistoryBloc>()
                                .add(const HistoryRedo());
                          }
                        : null,
                    tooltip: "Ponów",
                    icon: const Icon(Icons.redo_rounded),
                  ),
                ],
              ),
              if (state.status == HistoryStatus.success)
                if (state.history.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Column(
                          children: [
                            HistoryActionTile(
                              historyAction: state.history[index],
                            ),
                          ],
                        );
                      },
                      childCount: state.history.length,
                    ),
                  )
                else
                  const SliverToBoxAdapter(
                    child: PageAlert(
                      leadingIconData: Icons.history_toggle_off_rounded,
                      title: "Brak historii",
                      text:
                          "\tPodczas dodawania, edycji lub usuwania produktów znajdować się tutaj będzie podgląd wykonanych akcji. Dzięki przyciskom na górnym pasku możesz je łatwo cofać i ponawiać. ",
                    ),
                  )
              else
                SliverToBoxAdapter(
                  child: PageAlert(
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
                )
            ],
          );
        },
      ),
    );
  }
}
