import 'package:flutter/services.dart';

class ExternalLinkAccountModal {
  static const MethodChannel _channel = MethodChannel('can_make_payments');

  /// Check if a payment is allowed. Must be checked before showing the modal.
  static Future<bool> get canMakePayments async {
    return await _channel.invokeMethod('canMakePayments');
  }

  /// Open the modal using native API if the current system runs iOS >16.0.
  static Future<bool> get openNativeModal async {
    return await _channel.invokeMethod('openNativeModal');
  }
}
