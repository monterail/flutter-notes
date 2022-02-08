import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/src/utils/widgets/cupertino_icon_button.dart';

void main() {
  testWidgets(
    'Forwards taps',
    (tester) async {
      int tapCount = 0;

      final widget = CupertinoApp(
          home: CupertinoIconButton(
        onTap: () => tapCount++,
        icon: const Icon(Icons.abc),
      ));

      await tester.pumpWidget(widget);

      await tester.tap(find.byWidget(widget));

      expect(tapCount, equals(1));
    },
  );

  testWidgets(
    'Renders given icon',
    (tester) async {
      const expectedIcon = Icons.abc;

      const widget = CupertinoApp(
          home: CupertinoIconButton(
        icon: Icon(expectedIcon),
      ));

      await tester.pumpWidget(widget);
      expect(find.byIcon(expectedIcon), findsOneWidget);
    },
  );
}
