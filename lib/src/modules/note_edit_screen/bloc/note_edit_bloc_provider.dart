import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/repositories/notes_repository/notes_repository.dart';

import 'note_edit_bloc.dart';

class NoteEditBlocProvider extends StatelessWidget {
  final Widget child;

  const NoteEditBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      RepositoryProvider<AbstractNoteRepository>(
        create: (context) => NoteRepository(),
        child: BlocProvider(
          create: (context) => NoteEditBloc(
            noteRepository: context.read<AbstractNoteRepository>(),
          ),
          child: child,
        ),
      );
}
