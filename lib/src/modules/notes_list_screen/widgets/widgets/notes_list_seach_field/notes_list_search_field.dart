import 'package:flutter/cupertino.dart';

class NotesListSeachField extends StatelessWidget {
  const NotesListSeachField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoTextField(
        decoration: BoxDecoration(
          color: CupertinoColors.secondarySystemFill,
          borderRadius: BorderRadius.circular(8),
        ),
        prefix: const Padding(
          padding: EdgeInsets.only(left: 6),
          child: Icon(
            CupertinoIcons.search,
            color: CupertinoColors.inactiveGray,
          ),
        ),
        placeholder: 'Search',
        placeholderStyle: const TextStyle(
          color: CupertinoColors.inactiveGray,
        ),
      );
}
