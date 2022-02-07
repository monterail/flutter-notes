import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:template/src/modules/note_edit_screen/bloc/note_edit_bloc.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NoteEditBloc, NoteEditState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            DateFormat('d MMMM yyyy, hh:mm')
                .format(state.note?.creation ?? DateTime.now()),
            key: ValueKey(state.note),
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  color: CupertinoColors.inactiveGray,
                ),
          ),
        ),
      );
}
