import 'package:flutter/cupertino.dart';

class NotesListNavbar extends StatelessWidget {
  const NotesListNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.back,
            size: 28,
          ),
          Text(
            'Folders',
            style: CupertinoTheme.of(context).textTheme.navActionTextStyle,
          ),
        ],
      );
}
