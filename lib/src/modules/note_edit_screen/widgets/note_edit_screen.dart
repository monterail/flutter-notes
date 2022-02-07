import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:template/src/modules/note_edit_screen/bloc/note_edit_bloc.dart';
import 'package:template/src/modules/note_edit_screen/bloc/note_edit_bloc_provider.dart';
import 'package:template/src/modules/note_edit_screen/widgets/widgets/date_header/date_header.dart';
import 'package:template/src/modules/note_edit_screen/widgets/widgets/delete_button/delete_button.dart';
import 'package:template/src/modules/note_edit_screen/widgets/widgets/new_button/new_button.dart';
import 'package:template/src/modules/note_edit_screen/widgets/widgets/share_button/share_button.dart';
import 'package:template/src/modules/note_edit_screen/widgets/widgets/text_field/text_field.dart';

class NoteEditScreen extends StatelessWidget implements AutoRouteWrapper {
  final int? noteId;

  const NoteEditScreen({
    Key? key,
    @PathParam('id') this.noteId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NoteEditBloc>().add(LoadNote(noteId));

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        previousPageTitle: 'Notes',
      ),
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 48),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    DateHeader(),
                    SizedBox(height: 4),
                    NoteTextField(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 40,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    DeleteNoteButton(),
                    ShareNoteButton(),
                    NewNoteButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) =>
      NoteEditBlocProvider(child: this);
}
