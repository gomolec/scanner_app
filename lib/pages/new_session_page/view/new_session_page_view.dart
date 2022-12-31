import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/pages/new_session_page/bloc/new_session_bloc.dart';
import '../../../repositories/repositories.dart';
import 'widgets/widgets.dart';

class NewSessionPage extends StatelessWidget {
  final String? initialSessionId;

  const NewSessionPage({
    Key? key,
    @PathParam() required this.initialSessionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewSessionBloc(
        sessionsRepository: context.read<SessionsRepository>(),
        initialSessionId: initialSessionId,
      )..add(const NewSessionSubscriptionRequested()),
      child: const NewSessionPageView(),
    );
  }
}

class NewSessionPageView extends StatelessWidget {
  const NewSessionPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select(
      (NewSessionBloc bloc) => bloc.state.status,
    );
    final isNewSession = context.select(
      (NewSessionBloc bloc) => bloc.state.isNewSession,
    );
    return BlocListener<NewSessionBloc, NewSessionState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == NewSessionStatus.success,
      listener: (context, state) => context.router.pop(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              context.router.pop();
            },
          ),
          title: Text(isNewSession ? "Nowa sesja" : "Edytuj sesje"),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              icon: const Icon(Icons.save_rounded),
              onPressed: status.isLoadingOrSuccess
                  ? null
                  : () {
                      context
                          .read<NewSessionBloc>()
                          .add(const NewSessionSubmitted());
                    },
            ),
          ],
        ),
        body: BlocBuilder<NewSessionBloc, NewSessionState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status == NewSessionStatus.initial) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      NameField(),
                      SizedBox(height: 24.0),
                      NoteField(),
                      SizedBox(height: 24.0),
                      AuthorField(),
                      SizedBox(height: 24.0),
                      DownloadUrlsField(),
                      SizedBox(height: 24.0),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
