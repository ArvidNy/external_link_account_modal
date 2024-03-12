import Flutter
import UIKit
import StoreKit

public class SwiftExternalLinkAccountModalPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "can_make_payments", binaryMessenger: registrar.messenger())
    let instance = SwiftExternalLinkAccountModalPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch (call.method) {
      case"canOpenExternalAccount":
       if #available(iOS 16.0, *) {
            Task {
              result(await ExternalLinkAccount.canOpen);
            }
          } else {
            result(SKPaymentQueue.canMakePayments());
          }
          break;
    case"canOpenExternalPurchase":
     if #available(iOS 17.4, *) {
          Task {
            result(await ExternalPurchaseLink.canOpen);
          }
        } else {
          result(false);
        }
        break;
      case"openNativeExternalAccountModal":
          if #available(iOS 16.0, *) {
            Task {
              do {
                try await ExternalLinkAccount.open();
                result(true);
              } catch {
                result(false);
              }
            }
          } else {
            result(false);
          }
        break;
    case"openNativePurchaseModal":
        if #available(iOS 17.4, *) {
             Task {
                 do {
                   try await ExternalPurchaseLink.open();
                   result(true);
                 } catch {
                   result(false);
                 }
             }
           } else {
             result(false);
        }

      default:
          result("Not Implemented!")
          break;
      }
  }
}
