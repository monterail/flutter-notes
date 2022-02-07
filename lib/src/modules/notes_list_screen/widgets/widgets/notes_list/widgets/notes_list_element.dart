import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:template/src/repositories/notes_repository/notes_repository.dart';

class NotesListElement extends StatelessWidget {
  final Note note;

  const NotesListElement({
    Key? key,
    required this.note,
  }) : super(key: key);

  String get title {
    // Make sure to use runes rather than characters
    // to avoid cutting multi-byte Unicode characters
    // in the middle.
    final titleRunes = note.content.runes.length > 100
        ? note.content.runes.toList().sublist(0, 100)
        : note.content.runes;

    return String.fromCharCodes(titleRunes);
  }

  String get description {
    if (note.content.runes.length <= 100) {
      return 'No additional text';
    }

    // Make sure to use runes rather than characters
    // to avoid cutting multi-byte Unicode characters
    // in the middle.
    final contentWithSkippedTitle = note.content.runes.skip(title.runes.length);
    final runes = contentWithSkippedTitle.length > 100
        ? contentWithSkippedTitle.toList().sublist(0, 100)
        : contentWithSkippedTitle;

    return String.fromCharCodes(runes);
  }

  String get creationDate {
    final lessThanWeekOld = note.creation.isAfter(
      DateTime.now().subtract(const Duration(days: 7)),
    );

    final dateFormat =
        lessThanWeekOld ? DateFormat('EEEE') : DateFormat('d/M/y');
    return dateFormat.format(note.creation);
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              '$creationDate   $description',
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    color: CupertinoColors.inactiveGray,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      );
}
