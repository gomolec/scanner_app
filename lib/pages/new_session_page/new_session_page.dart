import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';

//TODO nowy cubit, ktory zarzaca cala strona, strona powinna przyjmowac jako argument
//sesje, czyli mozna tez edytowac sesje, lub je tworzyc (kiedy argument == null)
class NewSessionPage extends StatelessWidget {
  const NewSessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController noteController = TextEditingController();
    //TODO powinno pobierać nazwę użytkownika
    final TextEditingController authorController = TextEditingController(
      text: "Sebastian Gomolec - programista",
    );
    //TODO powinno pobierać z ustawień
    bool downloadUrls = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            context.router.pop();
          },
        ),
        title: const Text("Nowa sesja"),
        titleSpacing: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save_rounded),
            onPressed: () {
              context.read<SessionsCubit>().createNewSession(
                    name: nameController.text,
                    note: noteController.text,
                    author: authorController.text,
                    downloadUrls: downloadUrls,
                  );
              context.router.pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nazwa',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "np. Dostawa magazyn",
                ),
              ),
              const SizedBox(height: 24.0),
              TextField(
                controller: noteController,
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Notatki',
                  hintText:
                      "Możesz umieścić tutaj ważne informacje dotyczące sesji",
                  hintMaxLines: 4,
                ),
              ),
              const SizedBox(height: 24.0),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Autor',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "np. Ania - magazyn",
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BETA - tylko sklep Krukam",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                        ),
                        Text(
                          "Pobieraj dane ze strony internetowej",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "Funkcja pobiera z bazy danych sklepu zdjęcie i inne parametry produktów",
                          maxLines: 3,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => Switch(
                      value: downloadUrls,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (value) {
                        setState(
                          () {
                            downloadUrls = !downloadUrls;
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
