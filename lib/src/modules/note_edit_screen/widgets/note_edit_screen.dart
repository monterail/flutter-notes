import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:template/src/modules/note_edit_screen/bloc/note_edit_bloc_provider.dart';

class NoteEditScreen extends StatelessWidget implements AutoRouteWrapper {
  const NoteEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      CupertinoPageScaffold(child: Container());

  @override
  Widget wrappedRoute(BuildContext context) =>
      NoteEditBlocProvider(child: this);
}
