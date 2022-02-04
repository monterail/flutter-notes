import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:template/src/modules/notes_list_screen/bloc/notes_list_bloc_provider.dart';

class NotesListScreen extends StatelessWidget implements AutoRouteWrapper {
  const NotesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: Container(),
      );

  @override
  Widget wrappedRoute(BuildContext context) =>
      NotesListBlocProvider(child: this);
}
