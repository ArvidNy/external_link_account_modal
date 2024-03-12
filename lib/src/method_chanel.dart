import 'package:flutter/services.dart';

class ExternalLinkAccountModal {
  static const MethodChannel _channel = MethodChannel('can_make_payments');

  /// Check if a payment is allowed. Must be checked before showing the modal.
  static Future<bool> get canOpenExternalAccount async {
    return await _channel.invokeMethod('canOpenExternalAccount');
  }

  /// Check if a external payment is allowed. Must be checked before showing the modal.
  static Future<bool> get canOpenExternalPurchase async {
    return await _channel.invokeMethod('canOpenExternalPurchase');
  }

  /// Open the external account modal using native API if the current system runs iOS >16.0.
  static Future<bool> get openNativeExternalAccountModal async {
    return await _channel.invokeMethod('openNativeExternalAccountModal');
  }
  
  /// Open the purchase modal using native API if the current system runs iOS >17.4.
  static Future<bool> get openNativePurchaseModal async {
    return await _channel.invokeMethod('openNativePurchaseModal');
  }
}
