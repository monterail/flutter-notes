import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/modules/note_edit_screen/bloc/note_edit_bloc.dart';

class NoteTextField extends StatefulWidget {
  const NoteTextField({Key? key}) : super(key: key);

  @override
  _NoteTextFieldState createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<NoteEditBloc, NoteEditState>(
        listener: (context, state) {
          if (_controller.text.isEmpty && state.note != null) {
            _controller.text = state.note!.content;
            FocusScope.of(context).unfocus();
            return;
          }
          _focusNode.requestFocus();
          if (_controller.text.isNotEmpty &&
              (state.note == null || state.note!.content.isEmpty)) {
            _controller.clear();
          }
        },
        child: CupertinoTextField.borderless(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          maxLines: null,
          onChanged: (content) =>
              context.read<NoteEditBloc>().add(UpdateContent(content)),
        ),
      );
}
