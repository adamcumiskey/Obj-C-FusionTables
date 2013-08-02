//
//  SimpleGoogleServiceHelpers.m
//  Obj-C-FusionTables
//
//  Created by Arseniy Kuznetsov on 9/7/11.
//  Copyright 2011 Arseniy Kuznetsov. All rights reserved.
//

#import "SimpleGoogleServiceHelpers.h"
#import "GoogleAuthorizationController.h"

@interface SimpleGoogleServiceHelpers ()
    @property (nonatomic, strong) UIActivityIndicatorView *spinner;
@end

@implementation SimpleGoogleServiceHelpers {
    NSUInteger networkActivityIndicatorCounter;
}

#pragma mark - Singleton instance
+ (SimpleGoogleServiceHelpers *)sharedInstance {
    static SimpleGoogleServiceHelpers *sharedSimpleGoogleServiceHelperInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedSimpleGoogleServiceHelperInstance = [[[self class] alloc] init];
    });
    return sharedSimpleGoogleServiceHelperInstance;
}

#pragma mark Initialization
- (id)init {
    self = [super init];
    if (self) {
        networkActivityIndicatorCounter = 0;
    }
    return self;
}
- (UIActivityIndicatorView *)spinner {
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _spinner;
}

#pragma mark Public Methods
#pragma mark - Network Activity
- (void)incrementNetworkActivityIndicator {
    ++networkActivityIndicatorCounter;
    if (networkActivityIndicatorCounter == 1) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}
- (void)decrementNetworkActivityIndicator {
    --networkActivityIndicatorCounter;
    if (networkActivityIndicatorCounter == 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}
- (void)hideNetworkActivityIndicator {
    networkActivityIndicatorCounter = 0;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - Visual Indicators methods
- (void)showAlertViewWithTitle:(NSString *)title AndText:(NSString *)text {
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title 
                                                        message:text delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
	[alertView show];
}

#pragma mark - a Random Number
- (NSString *)random4DigitNumberString {
    int from = 1000, to = 9999;
    NSString *randomString = [NSString stringWithFormat:@"%i", (arc4random()%(to-from)) + from];
    return randomString;
}

#define GOOGLE_GDRIVE_API_URL @("https://www.googleapis.com/drive/v2/files")
- (void)setPublicSharingForFileWithID:(NSString *)fileID
                WithCompletionHandler:(ServiceAPIHandler)completionHandler {
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@", GOOGLE_GDRIVE_API_URL, fileID, @"permissions"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [[GoogleAuthorizationController sharedInstance] authorizeHTTPFetcher:fetcher WithCompletionHandler:^{
        
        NSMutableDictionary *permissionsDict = [NSMutableDictionary dictionary];
        permissionsDict[@"role"] = @"reader";
        permissionsDict[@"type"] = @"anyone";
        permissionsDict[@"value"] = @"";
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:permissionsDict
                                                           options:NSJSONWritingPrettyPrinted error:nil];
        [fetcher setPostData:jsonData];
        [fetcher beginFetchWithCompletionHandler:completionHandler];
    }];
}

#define GOOGLE_URL_SHORTENER_API_URL (@"https://www.googleapis.com/urlshortener/v1/url")
- (void)shortenURL:(NSString *)longURL
                        WithCompletionHandler:(ServiceAPIHandler)completionHandler {
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:GOOGLE_URL_SHORTENER_API_URL]];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    
    [[GoogleAuthorizationController sharedInstance] authorizeHTTPFetcher:fetcher WithCompletionHandler:^{            
        NSMutableDictionary* jsonObject = [NSMutableDictionary dictionary];
        jsonObject[@"longUrl"] = longURL;
        
        // convert object to data
        NSData *postData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                           options:NSJSONWritingPrettyPrinted error:nil];
        [fetcher setPostData:postData];
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [[GoogleAuthorizationController sharedInstance] authorizeHTTPFetcher:fetcher WithCompletionHandler:^{
            [fetcher setPostData:postData];
            [fetcher beginFetchWithCompletionHandler:completionHandler];
        }];
    }];
}

@end



/*
 
 NSString *jsonString = [[NSString alloc] initWithData:jsonData
 encoding:NSUTF8StringEncoding];
 NSData *postData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
 
*/





