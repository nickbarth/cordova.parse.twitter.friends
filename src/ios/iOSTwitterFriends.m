#import "iOSTwitterFriends.h"

@implementation iOSTwitterFriends

@synthesize callbackId;

- (void)iOSTwitterFriends:(CDVInvokedUrlCommand *)command {
    self.callbackId = command.callbackId;
    
    PFUser *currentUser = [PFUser currentUser];
    if (![PFTwitterUtils isLinkedWithUser:currentUser]) {
        [PFTwitterUtils linkUser:currentUser block:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSString *result = @"{ \"error\": \"Invalid Session\" }";
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
                [self writeJavascript:javaScript];
            } else {
                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/friends/list.json"];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [[PFTwitterUtils twitter] signRequest:request];
                
                NSError *error;
                NSURLResponse *urlResponse = nil;
                NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
                
                if (response == nil) {
                    if (error) {
                        NSLog(@"Error: %@", error);
                        NSString *result = @"{ \"error\": \"Invalid Session\" }";
                        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                        NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
                        [self writeJavascript:javaScript];
                    } else {
                        NSLog(@"Request Failed");
                        NSString *result = [NSString stringWithFormat:@"{ \"error\": \"Request Failed\" }"];
                        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                        NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
                        [self writeJavascript:javaScript];
                    }
                    return;
                }
                
                NSString *result = [NSString stringWithFormat: @"{ \"error\": false, \"friends\": ["];
                NSError *errorJson = nil;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&errorJson];
                NSArray *friends = json[@"users"];
                
                for (NSDictionary *friend in friends) {
                    result = [NSString stringWithFormat:@"%@ { \"username\": \"%@\", \"name\": \"%@\", \"picture\": \"%@\"},",
                              result, friend[@"screen_name"], friend[@"name"], friend[@"profile_image_url"]];
                }
                
                if ([friends count] > 1) {
                    result = [NSString stringWithFormat:@"%@] }", [result substringToIndex:[result length] - 1]];
                } else {
                    result = [NSString stringWithFormat:@"%@] }", result];
                }
                
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
                [self writeJavascript:javaScript];
            }
        }];
    } else {
        NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/friends/list.json"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [[PFTwitterUtils twitter] signRequest:request];
        
        NSError *error;
        NSURLResponse *urlResponse = nil;
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        if (response == nil) {
            if (error) {
                NSLog(@"Error: %@", error);
                NSString *result = "{ \"error\": \"Invalid Session\" }";
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
                [self writeJavascript:javaScript];
            } else {
                NSLog(@"Request Failed");
                NSString *result = [NSString stringWithFormat:@"{ \"error\": \"Request Failed\" }"];
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
                [self writeJavascript:javaScript];
            }
            return;
        }
        
        NSString *result = [NSString stringWithFormat: @"{ \"error\": false, \"friends\": ["];
        NSError *errorJson = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&errorJson];
        NSArray *friends = json[@"users"];
        
        for (NSDictionary *friend in friends) {
            result = [NSString stringWithFormat:@"%@ { \"username\": \"%@\", \"name\": \"%@\", \"picture\": \"%@\"},",
                      result, friend[@"screen_name"], friend[@"name"], friend[@"profile_image_url"]];
        }
        
        if ([friends count] > 1) {
            result = [NSString stringWithFormat:@"%@] }", [result substringToIndex:[result length] - 1]];
        } else {
            result = [NSString stringWithFormat:@"%@] }", result];
        }
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
        NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
        [self writeJavascript:javaScript];
    }
}

@end
