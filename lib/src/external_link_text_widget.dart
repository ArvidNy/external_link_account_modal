import 'dart:async';

import 'package:flutter/material.dart';

import 'clickable_link.dart';
import 'modal.dart';
import 'templates.dart';

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
            locale: locale ?? '',
            onCanMakePaymentsFailed: onCanMakePaymentsFailed));
  }
}

class ExternalLinkPurchaseText extends StatelessWidget {
  /// Creates a simple link that shows an in-app modal before leaving the app.
  ///
  /// Example usage:
  /// ```
  /// Scaffold(
  ///    body: const Center(
  ///      child: ExternalLinkPurchaseText(
  ///        url: 'https://example.com',
  ///        developerName: 'Example Developer',
  ///      ),
  ///    ),
  /// );
  /// ```
  const ExternalLinkPurchaseText({
    Key? key,
    required this.developerName,
    required this.url,
    this.text = TextTemplate.purchaseFromTheWebsite,
    this.customText,
    this.locale,
    this.onCanMakePaymentsFailed,
    this.textAlign = TextAlign.center,
    this.deal,
    this.splitValue = SplitValue.none,
  })  : assert((text == TextTemplate.toGetPercentOff ||
                text == TextTemplate.buyFor)
            ? deal != null
            : true),
        super(key: key);

  /// The name that will be visible in the text as the developer responsible for the link content.
  ///
  /// *This is only used in the Flutter version, for iOS >16.0 the developer name will be retrieved from
  /// the App Store Metadata. Before release, the name will say 'None'.*
  final String developerName;

  /// The URL that should be opened.
  ///
  /// *This is only used in the Flutter version, for iOS >16.0 [the URL added in the Info.plist](https://developer.apple.com/support/reader-apps/#updating-plistinfo) will be opened.*
  final String url;

  /// The text of the link.
  ///
  /// Use the default templates provided from Apple or use a [customText].
  final TextTemplate text;

  /// Optionally use a custom text for the link.
  ///
  /// Please note that Apple might not approve any text. For more info, see https://developer.apple.com/support/apps-using-alternative-payment-providers-in-the-eu
  final String? customText;

  /// Optionally set the locale to be used if other than the current device locale.
  ///
  /// *Only applicable for iOS <16.0*.
  final String? locale;

  /// Optionally run code if payments cannot be made and the modal will not open.
  final void Function()? onCanMakePaymentsFailed;

  /// Optionally set the text alignment in the link.
  final TextAlign textAlign;

  /// Deal value for [TextTemplate.buyFor] or [TextTemplate.toGetPercentOff].
  ///
  /// For [TextTemplate.toGetPercentOff] the percent is added, so plain numbers would be enough.
  ///
  /// For [TextTemplate.buyFor] no currency is added by default, so the value should for example be `deal: "\$20"`.
  ///
  /// Must be set if either of the above is used.
  final String? deal;

  ///
  final SplitValue splitValue;

  FutureOr<String?> get _text {
    if (customText != null) return customText;
    return text.localized(locale).then((value) => _splitStringInHalf(
            value
                ?.replaceAll('www.example.com', url)
                .replaceAll('@price', deal ?? '')
                .replaceAll('XX', deal ?? ''),
            splitValue)
        .join(''));
  }

  @override
  Widget build(BuildContext context) {
    return ClickableLink(
        text: _text,
        textAlign: textAlign,
        linkStyle: LinkStyle.iOSButton,
        onTap: () => showExternalLinkModal(context, developerName, url,
            locale: locale ?? '',
            onCanMakePaymentsFailed: onCanMakePaymentsFailed));
  }

  List<String?> _splitStringInHalf(String? str, SplitValue split) {
    switch (split) {
      case SplitValue.half:
        var spaceIndex = str?.indexOf(' ', str.length ~/ 2);
        if (spaceIndex == -1) return [str];
        return [
          str?.substring(0, spaceIndex),
          '\n',
          str?.substring(spaceIndex ?? 0)
        ];
      case SplitValue.beforeUrl:
        return [str?.replaceAll(url, '\n$url')];
      case SplitValue.none:
        return [str];
    }
  }
}

enum SplitValue {
  half,
  beforeUrl,
  none;
}
