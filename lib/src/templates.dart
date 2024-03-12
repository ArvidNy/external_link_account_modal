import 'localization_handler.dart';
import 'strings.dart';

enum TextTemplate {
  purchaseFromTheWebsite('CommerceUI.IOS.StorekitExternalLink.Text1'),
  forSpecialOffers('CommerceUI.IOS.StorekitExternalLink.Text2'),
  forASpecialOffer('CommerceUI.IOS.StorekitExternalLink.Text3'),
  lowerPricesOffered('CommerceUI.IOS.StorekitExternalLink.Text4'),
  lowerPriceOffered('CommerceUI.IOS.StorekitExternalLink.Text5'),
  toGetPercentOff('CommerceUI.IOS.StorekitExternalLink.Text6'),
  buyFor('CommerceUI.IOS.StorekitExternalLink.Text7');

  final String label;

  const TextTemplate(this.label);

  Future<String?> localized([String? customLocale]) async {
    var localizationHandler = LocalizationHandler(textTemplates);
    var locale = customLocale ?? await localizationHandler.getLocale();
    return localizationHandler.getString(label, locale);
  }
}