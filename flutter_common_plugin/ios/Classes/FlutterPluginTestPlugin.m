#import "FlutterCommonPluginPlugin.h"
#import <flutter_common_plugin/flutter_common_plugin-Swift.h>

@implementation FlutterCommonPluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCommonPluginPlugin registerWithRegistrar:registrar];
}
@end
