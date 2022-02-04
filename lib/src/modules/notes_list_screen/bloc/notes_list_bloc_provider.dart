import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/repositories/notes_repository/notes_repository.dart';

import 'notes_list_bloc.dart';

class NotesListBlocProvider extends StatelessWidget {
  final Widget child;

  const NotesListBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      RepositoryProvider<AbstractNoteRepository>(
        create: (context) => NoteRepository(),
        child: BlocProvider(
          create: (context) => NotesListBloc(
            noteRepository: context.read<AbstractNoteRepository>(),
          ),
          child: child,
        ),
      );
}
