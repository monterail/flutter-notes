import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/config/routes.dart';
import 'package:template/src/modules/notes_list_screen/bloc/notes_list_bloc.dart';
import 'package:template/src/modules/notes_list_screen/widgets/widgets/notes_list/widgets/notes_list_element.dart';

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  Future<void> _handleRedirect(BuildContext context, int noteId) async {
    await context.router.pushNamed(Routes.editNote(id: noteId));
    context.read<NotesListBloc>().add(LoadNotes());
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotesListBloc, NotesListState>(
        builder: (context, state) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.only(
            left: 30,
          ),
          decoration: BoxDecoration(
            color: CupertinoColors.quaternarySystemFill,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.notes.length,
            itemBuilder: (context, index) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _handleRedirect(context, state.notes[index].id),
              child: NotesListElement(note: state.notes[index]),
            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: CupertinoColors.separator,
            ),
          ),
        ),
      );
}
