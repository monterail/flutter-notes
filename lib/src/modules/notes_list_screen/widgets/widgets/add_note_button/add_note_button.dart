import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/config/routes.dart';
import 'package:template/src/modules/notes_list_screen/bloc/notes_list_bloc.dart';
import 'package:template/src/utils/widgets/cupertino_icon_button.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({Key? key}) : super(key: key);

  Future<void> _handleRedirect(BuildContext context) async {
    await context.router.pushNamed(Routes.editNote());
    context.read<NotesListBloc>().add(LoadNotes());
  }

  @override
  Widget build(BuildContext context) => CupertinoIconButton(
        onTap: () => _handleRedirect(context),
        icon: const Icon(CupertinoIcons.add),
      );
}
