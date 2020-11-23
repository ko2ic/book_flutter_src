#import "SamplePlugin.h"
#if __has_include(<sample_plugin/sample_plugin-Swift.h>)
#import <sample_plugin/sample_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sample_plugin-Swift.h"
#endif

@implementation SamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSamplePlugin registerWithRegistrar:registrar];
}
@end
