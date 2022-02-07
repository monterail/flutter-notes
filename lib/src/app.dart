import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:template/src/config/routes.dart';

/// The Widget that configures your application.
class NotesApp extends StatelessWidget {
  NotesApp({Key? key}) : super(key: key);

  final router = AppRouter();

  @override
  Widget build(BuildContext context) => CupertinoApp.router(
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
        // Providing a restorationScopeId allows the Navigator built by the
        // MaterialApp to restore the navigation stack when a user leaves and
        // returns to the app after it has been killed while running in the
        // background.
        restorationScopeId: 'app',

        // Provide the generated AppLocalizations to the MaterialApp. This
        // allows descendant Widgets to display the correct translations
        // depending on the user's locale.
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],

        theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.systemYellow,
          barBackgroundColor: CupertinoColors.systemBackground,
          scaffoldBackgroundColor: CupertinoColors.systemBackground,
        ),

        // Use AppLocalizations to configure the correct application title
        // depending on the user's locale.
        //
        // The appTitle is defined in .arb files found in the localization
        // directory.
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
      );
}
