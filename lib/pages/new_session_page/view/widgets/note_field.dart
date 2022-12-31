import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/new_session_bloc.dart';

class NoteField extends StatelessWidget {
  const NoteField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NewSessionBloc>().state;
    return TextFormField(
      key: const Key('newSessionView_note_textFormField'),
      initialValue: state.note,
      keyboardType: TextInputType.multiline,
      minLines: 4,
      maxLines: null,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Notatki',
        hintText: "Możesz umieścić tutaj ważne informacje dotyczące sesji",
        hintMaxLines: 4,
      ),
      onChanged: (value) {
        context.read<NewSessionBloc>().add(NewSessionNoteChanged(value));
      },
    );
  }
}
