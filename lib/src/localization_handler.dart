import 'package:devicelocale/devicelocale.dart';

class LocalizationHandler {
  final String _localizedStrings;
  late final List<String> _languages;
  late final List<Map<String, String>> stringListMap;
  LocalizationHandler(this._localizedStrings) {
    /// The list of string maps
    final list = _localizedStrings.split("\n");

    /// The list of available languages
    _languages = list.first.split(";");

    /// The list of maps containing localized strings.
    ///
    /// The value of the key `KEY` is the lable name (e.g. AppStore.FullSheet.ExternalPurchases.Title)
    ///
    /// The localized string is mapped under the corresponding locale (e.g. 'en')
    stringListMap = list
        .skip(1)
        .map((e) => Map.fromIterables(_languages, e.split(";")))
        .toList();
  }

  /// Detect which locale the device currently uses
  Future<String> getLocale({String deviceLocale = ''}) async {
    if (deviceLocale.isNotEmpty) return deviceLocale;
    List? deviceLanguages = await Devicelocale.preferredLanguages;
    if (deviceLanguages != null) deviceLocale = deviceLanguages.first;
    if (!_languages.contains(deviceLocale) &&
        _languages.contains(deviceLocale.split("-").first)) {
      deviceLocale = deviceLocale.split("-").first;
    }
    return deviceLocale;
  }

  /// Get the localized string
  String? getString(String s, String locale) {
    return stringListMap.firstWhere((element) => element['KEY'] == s)[locale];
  }
}
