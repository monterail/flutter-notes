import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:template/src/modules/note_edit_screen/widgets/note_edit_screen.dart';
import 'package:template/src/modules/notes_list_screen/widgets/notes_list_screen.dart';

part 'routes.gr.dart';

class Routes {
  // Routes without params
  static const notesList = '/';

  // Routes with params
  static String editNote({int? id}) => '/note/$id';
}

@AdaptiveAutoRouter(routes: [
  AutoRoute(page: NotesListScreen, initial: true),
  AutoRoute(page: NoteEditScreen, path: '/note/:id'),
])
class AppRouter extends _$AppRouter {}
