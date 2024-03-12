import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'theme.dart';

/// A simple "classic" link widget (underlined, blue text) that is clickable.
class ClickableLink extends StatelessWidget {
  /// A simple "classic" link widget (underlined, blue text) that is clickable.
  ///
  /// Example:
  /// ```
  /// ClickableLink(
  ///   text: url,
  ///   onTap: () => showExternalLinkModal(context, developerName, url,
  ///       locale: locale ?? ''));
  /// ```
  const ClickableLink(
      {Key? key,
      required this.text,
      required this.onTap,
      this.textAlign = TextAlign.start,
      this.linkStyle = LinkStyle.blueLink})
      : super(key: key);

  /// The text to be visible (i.e. the URL)
  final FutureOr<String?> text;

  /// The acction to be performed when the link is clicked
  final void Function() onTap;

  /// The link alignment
  final TextAlign textAlign;

  /// The link style
  final LinkStyle linkStyle;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: LinkText(text, textAlign: textAlign, linkStyle: linkStyle),
    );
  }
}

/// The base of a link widget (underlined, blue text) that is not clickable
class LinkText extends StatelessWidget {
  /// The base of a link widget (underlined, blue text) that is not clickable
  const LinkText(this.text,
      {Key? key,
      this.textAlign = TextAlign.start,
      this.linkStyle = LinkStyle.blueLink})
      : super(key: key);

  /// The text to be visible (i.e. the URL)
  final FutureOr<String?> text;

  /// The link alignment
  final TextAlign textAlign;

  /// The link style
  final LinkStyle linkStyle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: text is Future<String?>
            ? text as Future<String?>
            : Future.value(text),
        builder: (context, snapshot) {
          return Text.rich(
            TextSpan(children: [
              TextSpan(text: snapshot.data),
              if (linkStyle == LinkStyle.iOSButton) const TextSpan(text: ' '),
              if (linkStyle == LinkStyle.iOSButton)
                WidgetSpan(
                  child: Image.asset(
                    'lib/img/link-out.png',
                    height: 18,
                    color: systemPurple,
                    package: 'external_link_account_modal',
                  ),
                )
            ]),
            textAlign: textAlign,
            style: TextStyle(
              color:
                  linkStyle == LinkStyle.iOSButton ? systemPurple : systemBlue,
            ),
          );
        });
  }
}

enum LinkStyle { blueLink, iOSButton }
