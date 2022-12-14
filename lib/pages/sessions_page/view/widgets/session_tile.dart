import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/pages/pages.dart';
import '../../../../models/models.dart';
import '../../../../routes/router.gr.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';

class SessionTile extends StatelessWidget {
  final bool actual;
  final Session session;

  const SessionTile({
    Key? key,
    this.actual = false,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 24.0,
        top: 12.0,
        bottom: 12.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          () {
            late final IconData iconData;
            late final Color color;
            if (actual == true) {
              iconData = Icons.timer_outlined;
              color = Theme.of(context)
                  .extension<CustomColors>()!
                  .successContainer!;
            } else {
              if (session.endDate != null) {
                iconData = Icons.save_rounded;
                color = Theme.of(context).colorScheme.errorContainer;
              } else {
                iconData = Icons.warning_amber_rounded;
                color = Theme.of(context)
                    .extension<CustomColors>()!
                    .warningContainer!;
              }
            }
            return Container(
              alignment: Alignment.center,
              height: 56.0,
              width: 56.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Icon(
                iconData,
                size: 24.0,
              ),
            );
          }(),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  () {
                    if (session.name.isNotEmpty) {
                      return session.name;
                    }
                    if (actual == true) {
                      return "Aktualna sesja";
                    } else {
                      if (session.endDate == null) {
                        return "Niezako??czona sesja";
                      } else {
                        return "Zako??czona sesja";
                      }
                    }
                  }(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  () {
                    if (session.endDate != null) {
                      return "Utworzona ${DateFormat("dd.MM.yyyy HH:mm").format(session.startDate)}"
                          "\nZako??czona ${DateFormat("dd.MM.yyyy HH:mm").format(session.endDate!)}";
                    }
                    return "Utworzona ${DateFormat("dd.MM.yyyy HH:mm").format(session.startDate)}";
                  }(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 2.0),
                Text(
                  "Autor ${session.author.isEmpty ? "nieznany" : session.author}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                session.note.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.notes_rounded,
                              size: 16.0,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(
                                session.note,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Container(
            alignment: Alignment.center,
            height: 56.0,
            child: PopupMenuButton(
              tooltip: "Poka?? opcje",
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                actual
                    ? CustomPopupMenuItem(
                        title: "Zako??cz",
                        iconData: Icons.save_rounded,
                        onTap: () {
                          context
                              .read<SessionsBloc>()
                              .add(SessionEnded(id: session.id));
                        },
                      )
                    : CustomPopupMenuItem(
                        title: "Przywr????",
                        iconData: Icons.open_in_new_rounded,
                        onTap: () {
                          context
                              .read<SessionsBloc>()
                              .add(SessionRestored(id: session.id));
                        },
                      ),
                CustomPopupMenuItem(
                  title: "Exportuj",
                  iconData: Icons.file_upload_outlined,
                  onTap: () {},
                ),
                CustomPopupMenuItem(
                  title: "Edytuj",
                  iconData: Icons.edit,
                  onTap: () {
                    context.router
                        .push(NewSessionRouter(initialSessionId: session.id));
                  },
                ),
                const PopupMenuDivider(),
                CustomPopupMenuItem(
                  title: "Usu??",
                  iconData: Icons.delete_outlined,
                  onTap: () {
                    context
                        .read<SessionsBloc>()
                        .add(SessionDeleted(id: session.id));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
