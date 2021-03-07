#import "UistatePlugin.h"
#if __has_include(<uistate/uistate-Swift.h>)
#import <uistate/uistate-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "uistate-Swift.h"
#endif

@implementation UistatePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUistatePlugin registerWithRegistrar:registrar];
}
@end
