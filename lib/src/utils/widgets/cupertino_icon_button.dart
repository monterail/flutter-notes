import 'package:flutter/widgets.dart';

class CupertinoIconButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget icon;

  const CupertinoIconButton({
    Key? key,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
        ),
      );
}
