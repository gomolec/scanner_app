import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';
import 'widgets/menu_list_tile.dart';
import 'widgets/user_info_header.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const UserInfoHeader(),
            const SizedBox(height: 4.0),
            MenuListTile(
              leadingIcon: Icons.person,
              title: "Profil użytkownika",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: Icons.timer_outlined,
              title: "Sesje",
              onTap: () {
                context.router.push(const SessionsRouter());
              },
            ),
            MenuListTile(
              leadingIcon: Icons.file_download_outlined,
              title: "Import",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: Icons.file_upload_outlined,
              title: "Eksport",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: Icons.help_outline_rounded,
              title: "Pomoc",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: Icons.settings_rounded,
              title: "Ustawienia",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: Icons.exit_to_app_rounded,
              title: "Wyczyść dane",
              onTap: () {},
            ),
            const SizedBox(height: 16.0),
            Text(
              "Wersja 0.0.3\nCopyright © 2022 Sebastian Gomolec\ngomolecs@gmail.com\nAll rights reserved",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
