import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/new_session_bloc.dart';

class NameField extends StatelessWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NewSessionBloc>().state;
    return TextFormField(
      key: const Key('newSessionView_name_textFormField'),
      initialValue: state.name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nazwa',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "np. Dostawa magazyn",
      ),
      onChanged: (value) {
        context.read<NewSessionBloc>().add(NewSessionNameChanged(value));
      },
    );
  }
}
