import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:template/src/modules/notes_list_screen/bloc/notes_list_bloc_provider.dart';

class NotesListScreen extends StatelessWidget implements AutoRouteWrapper {
  const NotesListScreen({Key? key}) : super(key: key);

  String notesCountText(int count) {
    if (count == 0) {
      return 'No Notes';
    }
    if (count == 1) {
      return '1 Note';
    }
    return '$count Notes';
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    leading: Transform.translate(
                      offset: const Offset(-6, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            CupertinoIcons.back,
                            size: 28,
                          ),
                          Text(
                            'Folders',
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navActionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    largeTitle: const Text('Notes'),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CupertinoTextField(
                            decoration: BoxDecoration(
                              color: CupertinoColors.lightBackgroundGray,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                CupertinoIcons.search,
                                color: CupertinoColors.placeholderText,
                              ),
                            ),
                            placeholder: 'Search',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  notesCountText(0),
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .textStyle
                      .copyWith(fontSize: 12),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(CupertinoIcons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget wrappedRoute(BuildContext context) =>
      NotesListBlocProvider(child: this);
}
