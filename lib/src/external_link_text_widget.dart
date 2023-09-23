import 'package:flutter/material.dart';

import 'clickable_link.dart';
import 'modal.dart';

/// A simple link that shows an in-app modal before leaving the app.
class ExternalLinkAccountText extends StatelessWidget {
  /// Creates a simple link that shows an in-app modal before leaving the app.
  ///
  /// Example usage:
  /// ```
  /// Scaffold(
  ///    body: const Center(
  ///      child: ExternalLinkAccountText(
  ///        url: 'https://example.com',
  ///        developerName: 'Example Developer',
  ///      ),
  ///    ),
  /// );
  /// ```
  const ExternalLinkAccountText(
      {Key? key,
      required this.developerName,
      required this.url,
      this.locale,
      this.onCanMakePaymentsFailed})
      : super(key: key);

  /// The name that will be visible in the text as the developer responsible for the link content.
  /// 
  /// *This is only used in the Flutter version, for iOS >16.0 the developer name will be retrieved from
  /// the App Store Metadata. Before release, the name will say 'None'.*
  final String developerName;

  /// The URL that should be opened.
  /// 
  /// *This is only used in the Flutter version, for iOS >16.0 [the URL added in the Info.plist](https://developer.apple.com/support/reader-apps/#updating-plistinfo) will be opened.*
  final String url;

  /// Optionally set the locale to be used if other than the current device locale.
  /// 
  /// *Only applicable for iOS <16.0*.
  final String? locale;

  /// Optionally run code if payments cannot be made and the modal will not open.
  final void Function()? onCanMakePaymentsFailed;

  @override
  Widget build(BuildContext context) {
    return ClickableLink(
        text: url,
        onTap: () => showExternalLinkModal(context, developerName, url,
            locale: locale ?? '', onCanMakePaymentsFailed: onCanMakePaymentsFailed));
  }
}
