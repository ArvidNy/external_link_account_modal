import 'package:flutter/material.dart';

import 'theme.dart';

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
      this.textAlign = TextAlign.start})
      : super(key: key);

  /// The text to be visible (i.e. the URL)
  final String text;

  /// The acction to be performed when the link is clicked
  final void Function() onTap;

  /// The link alignment
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LinkText(
        text,
        textAlign: textAlign,
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  /// The base of a link widget (underlined, blue text) that is not clickable
  const LinkText(this.text, {Key? key, this.textAlign = TextAlign.start})
      : super(key: key);

  /// The text to be visible (i.e. the URL)
  final String text;

  /// The link alignment
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? systemBlue
              : systemBlueDark,
          decoration: TextDecoration.underline),
      textAlign: textAlign,
    );
  }
}
