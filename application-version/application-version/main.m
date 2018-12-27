
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

extern NSString *NSApplicationInfoDictionaryShortVersionKey;

NSString *NSApplicationInfoDictionaryShortVersionKey = @"CFBundleShortVersionString";

@interface NSBundle (NSApplication)

- (NSString *)shortVersionString;

@end

@implementation NSBundle (NSApplication)

- (NSString *)shortVersionString {
    return (NSString *)self.infoDictionary[NSApplicationInfoDictionaryShortVersionKey];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray <NSRunningApplication *>*running = running;
        for (NSRunningApplication *app in [NSWorkspace sharedWorkspace].runningApplications) {
            NSString *name = app.localizedName;
            NSString *version = [[NSBundle alloc] initWithURL:app.bundleURL].shortVersionString;
            NSLog(@"\"%@\" %@", name, version);
        }
    }
    return 0;
}
