#import "ExternalLinkAccountModalPlugin.h"
#if __has_include(<external_link_account_modal/external_link_account_modal-Swift.h>)
#import <external_link_account_modal/external_link_account_modal-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "external_link_account_modal-Swift.h"
#endif

@implementation ExternalLinkAccountModalPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftExternalLinkAccountModalPlugin registerWithRegistrar:registrar];
}
@end
