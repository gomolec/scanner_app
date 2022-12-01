import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Theme.of(context).colorScheme.surface,
              surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
              elevation: 2.0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 16.0 + MediaQuery.of(context).viewPadding.top,
                  bottom: 24.0,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 96.0,
                      width: 96.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.faceSmile,
                        size: 56.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "Sebastian Gomolec",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                    Text(
                      "Sklep magazyn",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            MenuListTile(
              leadingIcon: FontAwesomeIcons.solidUser,
              title: "Profil użytkownika",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: FontAwesomeIcons.businessTime,
              title: "Sesje",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: FontAwesomeIcons.download,
              title: "Import",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: FontAwesomeIcons.upload,
              title: "Eksport",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: FontAwesomeIcons.solidCircleQuestion,
              title: "Pomoc",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: FontAwesomeIcons.gear,
              title: "Ustawienia",
              onTap: () {},
            ),
            MenuListTile(
              leadingIcon: FontAwesomeIcons.solidTrashCan,
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

class MenuListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final IconData trailingIcon;
  final void Function()? onTap;

  const MenuListTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    this.trailingIcon = FontAwesomeIcons.chevronRight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 56.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    height: 24.0,
                    width: 24.0,
                    alignment: Alignment.center,
                    child: FaIcon(
                      leadingIcon,
                      size: 18.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    height: 24.0,
                    width: 24.0,
                    alignment: Alignment.center,
                    child: FaIcon(
                      trailingIcon,
                      size: 16.0,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          thickness: 1.0,
          height: 8.0,
          indent: 16.0,
          endIndent: 16.0,
        ),
      ],
    );
  }
}
