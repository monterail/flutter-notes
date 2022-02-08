import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/notes_list_screen/bloc/notes_list_bloc.dart';
import 'package:template/src/modules/notes_list_screen/bloc/notes_list_bloc_provider.dart';

import 'widgets/add_note_button/add_note_button.dart';
import 'widgets/notes_count/notes_count.dart';
import 'widgets/notes_list/notes_list.dart';
import 'widgets/notes_list_navbar/notes_list_navbar.dart';
import 'widgets/notes_list_seach_field/notes_list_search_field.dart';

class NotesListScreen extends StatelessWidget implements AutoRouteWrapper {
  const NotesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NotesListBloc>().add(LoadNotes());

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  leading: Transform.translate(
                    offset: const Offset(-6, 0),
                    child: const NotesListNavbar(),
                  ),
                  largeTitle: const Text('Notes'),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: NotesListSeachField(),
                  ),
                ])),
                SliverList(
                  delegate: SliverChildListDelegate(
                    const [NotesList()],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 40,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    // occupy space to make other two widgets position
                    // at center and end layout
                    SizedBox(width: 30),
                    NotesCount(),
                    AddNoteButton(),
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
      NotesListBlocProvider(child: this);
}
