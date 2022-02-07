import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/notes_list_screen/bloc/notes_list_bloc.dart';

class NotesCount extends StatelessWidget {
  const NotesCount({Key? key}) : super(key: key);

  String notesCountText(int count) {
    if (count == 0) {
      return 'No Notes';
    }
    if (count == 1) {
      return '1 Note';
    }
    return '$count Notes';
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotesListBloc, NotesListState>(
        builder: (context, state) => Text(
          notesCountText(state.notes.length),
          style: CupertinoTheme.of(context)
              .textTheme
              .textStyle
              .copyWith(fontSize: 12),
        ),
      );
}
