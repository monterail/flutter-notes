import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/note_edit_screen/bloc/note_edit_bloc.dart';
import 'package:template/src/utils/widgets/cupertino_icon_button.dart';

class ShareNoteButton extends StatelessWidget {
  const ShareNoteButton({Key? key}) : super(key: key);

  void _handleTap(BuildContext context) {
    context.read<NoteEditBloc>().add(ShareNote());
  }

  @override
  Widget build(BuildContext context) => CupertinoIconButton(
        onTap: () => _handleTap(context),
        icon: const Icon(CupertinoIcons.share),
      );
}
