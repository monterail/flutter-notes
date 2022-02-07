import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/note_edit_screen/bloc/note_edit_bloc.dart';

class DeleteNoteButton extends StatelessWidget {
  const DeleteNoteButton({Key? key}) : super(key: key);

  void _handleTap(BuildContext context) {
    context.read<NoteEditBloc>().add(DeleteNote());
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _handleTap(context),
        child: const Icon(CupertinoIcons.delete),
      );
}
