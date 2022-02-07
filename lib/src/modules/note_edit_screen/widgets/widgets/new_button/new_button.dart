import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:template/src/config/routes.dart';

class NewNoteButton extends StatelessWidget {
  const NewNoteButton({Key? key}) : super(key: key);

  Future<void> _handleTap(BuildContext context) async {
    context.router.replaceNamed(Routes.editNote());
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _handleTap(context),
        child: const Icon(CupertinoIcons.add),
      );
}
