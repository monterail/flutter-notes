import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:template/main.dart' as app;
import 'package:template/src/app.dart';
import 'package:template/src/services/hive.dart';
import 'package:template/src/utils/widgets/cupertino_icon_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await setupHive();
  });

  testWidgets(
    'add 100 notes, delete 100 notes',
    (tester) async {
      // Use .boot() instead of .main() since Sentry wrapper breaks
      // Flutter's ability to probe current app state.
      runApp(NotesApp());
      await tester.pumpAndSettle();

      expect(find.text('No Notes'), findsOneWidget);

      final tests = List<int>.generate(10, (index) => index + 1);
      for (final testNumber in tests) {
        await tester.tap(find.byType(CupertinoIconButton));
        await tester.pumpAndSettle();

        final expectedText = 'note $testNumber';
        await tester.enterText(find.byType(CupertinoTextField), expectedText);
        await tester.pumpAndSettle(const Duration(milliseconds: 100));

        expect(find.text(expectedText), findsOneWidget);

        await tester.tap(find.text('Notes'));
        await tester.pumpAndSettle();

        expect(find.text(expectedText), findsOneWidget);
        expect(
          find.text(testNumber == 1 ? '1 Note' : '$testNumber Notes'),
          findsOneWidget,
        );
      }

      for (final testNumber in tests.reversed) {
        final expectedText = 'note $testNumber';
        await tester.tap(find.text(expectedText));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(CupertinoIcons.delete));
        await tester.pumpAndSettle();

        expect(find.text(expectedText), findsNothing);
        late final String expectedNotesSummary;
        switch (testNumber) {
          case 1:
            expectedNotesSummary = 'No Notes';
            break;
          case 2:
            expectedNotesSummary = '1 Note';
            break;
          default:
            expectedNotesSummary = '${testNumber - 1} Notes';
        }
        expect(find.text(expectedNotesSummary), findsOneWidget);
      }
    },
  );

  testWidgets(
    'edit a note',
    (tester) async {
      // Use .boot() instead of .main() since Sentry wrapper breaks
      // Flutter's ability to probe current app state.
      runApp(NotesApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CupertinoIconButton));
      await tester.pumpAndSettle();

      const initialText = 'note';
      await tester.enterText(find.byType(CupertinoTextField), initialText);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(find.text(initialText), findsOneWidget);

      await tester.tap(find.text('Notes'));
      await tester.pumpAndSettle();

      const editedText = 'edited note';
      await tester.tap(find.text(initialText));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(CupertinoTextField), editedText);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      await tester.tap(find.text('Notes'));
      await tester.pumpAndSettle();

      expect(find.text(editedText), findsOneWidget);
    },
  );

  testWidgets(
    'adds all new notes',
    (tester) async {
      // Use .boot() instead of .main() since Sentry wrapper breaks
      // Flutter's ability to probe current app state.
      runApp(NotesApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CupertinoIconButton));
      await tester.pumpAndSettle();

      const firstNoteText = 'first note';
      await tester.enterText(find.byType(CupertinoTextField), firstNoteText);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(find.text(firstNoteText), findsOneWidget);

      await tester.tap(find.byIcon(CupertinoIcons.add));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      const secondNoteText = 'second note';
      await tester.enterText(find.byType(CupertinoTextField), secondNoteText);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(find.text(secondNoteText), findsOneWidget);

      await tester.tap(find.text('Notes'));
      await tester.pumpAndSettle();

      expect(find.text(firstNoteText), findsOneWidget);
      expect(find.text(secondNoteText), findsOneWidget);
    },
  );
}
