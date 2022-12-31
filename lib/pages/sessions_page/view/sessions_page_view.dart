import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/pages/pages.dart';
import 'package:scanner_app/pages/sessions_page/view/widgets/session_tile.dart';
import 'package:scanner_app/repositories/repositories.dart';

import '../../../routes/router.gr.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionsBloc(
        sessionsRepository: context.read<SessionsRepository>(),
      )..add(const SessionsSubscriptionRequested()),
      child: const SessionsPageView(),
    );
  }
}

class SessionsPageView extends StatelessWidget {
  const SessionsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            leading: IconButton(
              onPressed: () {
                context.router.pop();
              },
              tooltip: 'Wróć',
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: const Text("Sesje użytkownika"),
            actions: [
              IconButton(
                onPressed: () {},
                tooltip: 'Importuj sesję',
                icon: const Icon(Icons.file_download_outlined),
              ),
              IconButton(
                onPressed: () {
                  context.router.push(NewSessionRouter(initialSessionId: null));
                },
                tooltip: 'Utwórz sesję',
                icon: const Icon(Icons.add_circle_outline_rounded),
              ),
            ],
          ),
          BlocBuilder<SessionsBloc, SessionsState>(
            builder: (context, state) {
              if (state.status == SessionsStatus.success) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (state.isActualSession && index == 0) {
                        return Column(
                          children: [
                            SessionTile(
                              session: state.sessions[index],
                              actual: true,
                            ),
                            const Divider(
                              height: 8,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                          ],
                        );
                      }
                      return SessionTile(
                        session: state.sessions[index],
                      );
                    },
                    childCount: state.sessions.length,
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          // BlocBuilder<SessionsCubit, SessionsState>(
          //   builder: (context, state) {
          //     if (state is SessionsLoaded && state.sessions.isNotEmpty) {
          //       return SliverList(
          //         delegate: SliverChildBuilderDelegate(
          //           (BuildContext context, int index) {
          //             final Session session = state.sessions[index];
          //             return Column(
          //               children: [
          //                 SessionTile(
          //                   session: session,
          //                   actual: session.id == state.actualSessionId,
          //                 ),
          //                 session.id == state.actualSessionId
          //                     ? const Divider(
          //                         height: 8,
          //                         thickness: 1,
          //                         indent: 16,
          //                         endIndent: 16,
          //                       )
          //                     : const SizedBox(),
          //               ],
          //             );
          //           },
          //           childCount: state.sessions.length,
          //         ),
          //       );
          //     } else {
          //       return SliverToBoxAdapter(
          //         child: PageAlert(
          //           leadingIconData: Icons.folder_off_rounded,
          //           title: "Brak zapisanych sesji",
          //           text:
          //               "\tAby móc zacząć korzystać z aplikacji musisz utworzyć sesję. Korzystając z przycisków poniżej lub tych znajdujących się na górnym pasku, możesz utworzyć nową (pustą) sesję lub zaimportować ją z obsługiwanych plików.",
          //           buttons: [
          //             ElevatedButton.icon(
          //               onPressed: () {
          //                 //TODO dodać przenoszenie do strony z tworzeniem sesji
          //                 context.read<SessionsCubit>().createNewSession();
          //               },
          //               icon: const Icon(Icons.create_new_folder_rounded),
          //               label: const Text("Utwórz nową sesję"),
          //             ),
          //             ElevatedButton.icon(
          //               onPressed: () {
          //                 //TODO dodać przenoszenie do ekranu importowania
          //               },
          //               icon: const Icon(Icons.download),
          //               label: const Text("Importuj sesję"),
          //             ),
          //           ],
          //         ),
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
