#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#import <Cordova/CDV.h>

@interface iOSTwitterFriends: CDVPlugin{
  NSString* callbackId;
}

@property (nonatomic, retain) NSString* callbackId;
- (void)iOSTwitterFriends:(CDVInvokedUrlCommand *)command;
@end
