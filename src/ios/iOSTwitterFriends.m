#import "iOSTwitterFriends.h"

@implementation iOSTwitterFriends

@synthesize callbackId;

- (void)iOSTwitterFriends:(CDVInvokedUrlCommand *)command {
    self.callbackId = command.callbackId;

    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/friends/list.json"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [[PFTwitterUtils twitter] signRequest:request];

    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSString *result = [NSString stringWithFormat:@"{ \"error\": \"%@\" }", error];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        } else {
            NSString *result = [NSString stringWithFormat: @"{ \"error\": false, \"friends\": ["];
            NSError *errorJson = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
            NSArray *friends = json[@"users"];

            for (NSDictionary *friend in friends) {
                result = [NSString stringWithFormat:@"%@ { \"username\": \"%@\", \"name\": \"%@\", \"picture\": \"%@\"},", 
                    result, friend[@"screen_name"], friend[@"name"], friend[@"profile_image_url"]];
            }

            result = [NSString stringWithFormat:@"%@] }", [result substringToIndex:[result length] - 1]];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        }
    }];
}

@end
