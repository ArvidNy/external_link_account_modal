import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'theme.dart';

/// A button typically used in a [CupertinoActionSheet].
///
/// See also:
///
///  * [CupertinoActionSheet], an alert that presents the user with a set of two or
///    more choices related to the current context.
class CustomCupertinoActionSheetAction extends StatelessWidget {
  /// Creates an action for an iOS-style action sheet.
  ///
  /// The [child] and [onPressed] arguments must not be null.
  const CustomCupertinoActionSheetAction(
      {Key? key, required this.onPressed, required this.child})
      : assert(onPressed != null),
        super(key: key);

  /// The callback that is called when the button is tapped.
  ///
  /// This attribute must not be null.
  final VoidCallback? onPressed;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontFamily: '.SF UI Text',
      inherit: false,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      textBaseline: TextBaseline.alphabetic,
      color: MediaQuery.of(context).platformBrightness == Brightness.light
          ? systemBlue
          : systemBlueDark,
    );

    return MouseRegion(
      cursor: onPressed != null && kIsWeb
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoDynamicColor.resolve(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? secondarySystemBackground
                    : secondarySystemBackgroundDark,
                context),
            borderRadius: const BorderRadius.all(Radius.circular(14.0)),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50.0,
            ),
            child: Semantics(
              button: true,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 10.0,
                ),
                child: DefaultTextStyle(
                    style: style, textAlign: TextAlign.center, child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
