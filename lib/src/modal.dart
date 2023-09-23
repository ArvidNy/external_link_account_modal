import 'package:device_info_plus/device_info_plus.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'clickable_link.dart';
import 'custom_cupertion_sheet_action.dart';
import 'method_chanel.dart';
import 'strings.dart';
import 'theme.dart';

/// Show the External Link Modal, either using the native API for iOS >16.0,
/// or a custom Flutter widget following the design requirements.
showExternalLinkModal(BuildContext context, String developerName, String url,
    {String locale = '', void Function()? onCanMakePaymentsFailed}) async {
  bool canMakePayment = await ExternalLinkAccountModal.canMakePayments;
  if (!canMakePayment) {
    if (onCanMakePaymentsFailed != null) onCanMakePaymentsFailed();
    return;
  }
  bool openNativeModal = await ExternalLinkAccountModal.openNativeModal;
  if (openNativeModal) return;
  locale = await _getLocale(deviceLocale: locale);
  currentDevice = await _setDevice();
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Padding(
      padding: EdgeInsets.only(
          top: currentDevice.modalMarginTop,
          bottom: currentDevice.modalMarginBottom),
      child: Container(
        constraints: BoxConstraints(maxWidth: currentDevice.maxWidth),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Scaffold(
            backgroundColor:
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? systemBackground
                    : systemBackgroundDark,
            body: Padding(
              padding: EdgeInsets.only(
                  top: currentDevice.topMargin,
                  bottom: currentDevice.bottomMargin,
                  right: currentDevice.sideMargin,
                  left: currentDevice.sideMargin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          _getString(
                                  'AppStore.FullSheet.ExternalPurchases.Title',
                                  locale) ??
                              defaultTitle,
                          textAlign: TextAlign.center,
                          style: MediaQuery.of(context).platformBrightness ==
                                  Brightness.light
                              ? titleStyle
                              : titleStyleDark,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: currentDevice.titleMargin),
                          child: Text(
                            (_getString('AppStore.FullSheet.ExternalPurchases.Body',
                                        locale) ??
                                    defaultBody)
                                .replaceAll('@@developerName@@', developerName),
                            textAlign: TextAlign.center,
                            style: MediaQuery.of(context).platformBrightness ==
                                    Brightness.light
                                ? bodyStyle
                                : bodyStyleDark,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                          child: ClickableLink(
                            text: _getString(
                                    'AppStore.FullSheet.ExternalPurchases.LearnMore',
                                    locale) ??
                                defaultLearnMore,
                            onTap: () => launchUrl(
                                Uri.parse(
                                    'https://apps.apple.com/story/id1614232807'),
                                mode: LaunchMode.externalApplication),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? systemBackground
                        : systemBackgroundDark,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: currentDevice.buttonMargin,
                          left: currentDevice.buttonMargin,
                          top: 24),
                      child: Column(
                        children: [
                          CustomCupertinoActionSheetAction(
                              onPressed: () {
                                launchUrl(Uri.parse(url),
                                    mode: LaunchMode.externalApplication);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                _getString(
                                        'AppStore.FullSheet.ExternalPurchases.Action1',
                                        locale) ??
                                    defaultAction1,
                                style:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? buttonStyle
                                        : buttonStyleDark,
                              )),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomCupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                _getString(
                                        'AppStore.FullSheet.ExternalPurchases.Action2',
                                        locale) ??
                                    defaultAction2,
                                style:
                                    MediaQuery.of(context).platformBrightness ==
                                            Brightness.light
                                        ? buttonStyle
                                        : buttonStyleDark,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// The currently detected device
DeviceType currentDevice = DeviceType.iPhone;

/// Detect which device is used to use correct margins
_setDevice() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  if (iosInfo.name.contains('iPad')) {
    return DeviceType.iPad;
  } else if (iosInfo.name.contains('iPhone SE')) {
    return DeviceType.iPhoneSe;
  } else if (iosInfo.name.contains('Plus') || iosInfo.name.contains('Max')) {
    return DeviceType.iPhoneMaxPlus;
  } else {
    return DeviceType.iPhone;
  }
}

/// The list of string maps
final list = localizedStrings.split("\n");

/// The list of available languages
final languages = list.first.split(";");

/// The list of maps containing localized strings.
///
/// The value of the key `KEY` is the lable name (e.g. AppStore.FullSheet.ExternalPurchases.Title)
///
/// The localized string is mapped under the corresponding locale (e.g. 'en')
final stringListMap = list
    .skip(1)
    .map((e) => Map.fromIterables(languages, e.split(";")))
    .toList();

/// Detect which locale the device currently uses
Future<String> _getLocale({String deviceLocale = ''}) async {
  if (deviceLocale.isNotEmpty) return deviceLocale;
  List? deviceLanguages = await Devicelocale.preferredLanguages;
  if (deviceLanguages != null) deviceLocale = deviceLanguages.first;
  if (!languages.contains(deviceLocale) &&
      languages.contains(deviceLocale.split("-").first)) {
    deviceLocale = deviceLocale.split("-").first;
  }
  return deviceLocale;
}

/// Get the localized string
_getString(String s, String locale) {
  return stringListMap.firstWhere((element) => element['KEY'] == s)[locale];
}

/// The different types of iOS models with corresponding layout variables
enum DeviceType {
  iPhone(sideMargin: 24.0),
  iPhoneSe(sideMargin: 16.0),
  iPhoneMaxPlus(sideMargin: 44.0),
  iPad(
      sideMargin: 88.0,
      bottomMargin: 40,
      buttonMargin: 44,
      topMargin: 88,
      titleMargin: 17,
      modalMarginTop: 44,
      modalMarginBottom: 44,
      maxWidth: 624);

  const DeviceType(
      {required this.sideMargin,
      this.buttonMargin = 0,
      this.topMargin = 70,
      this.bottomMargin = 27,
      this.titleMargin = 16,
      this.modalMarginTop = 27,
      this.modalMarginBottom = 0,
      this.maxWidth = double.infinity});
  final double sideMargin;
  final double bottomMargin;
  final double topMargin;
  final double buttonMargin;
  final double titleMargin;
  final double modalMarginBottom;
  final double modalMarginTop;
  final double maxWidth;
}
