//
//  AppDelegate.m
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/5.
//  Copyright © 2018年 zm. All rights reserved.
//


#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate+Notification.h"
#import <CommonCrypto/CommonDigest.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (void)downloadAndSaveWithURL:(NSURL*)url
             completionHandler:(void(^)(NSURL *))completionHandler
{
    
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                  if (data) {
                                                                      NSString *ret = url.absoluteString.pathExtension;
                                                                      NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                                                                      NSURL *cacheUrl = [NSURL fileURLWithPath:cachePath];
                                                                      NSString *fileName = [[self md5:url.absoluteString] stringByAppendingPathExtension:ret];
                                                                      NSURL *loacalUrl = [cacheUrl URLByAppendingPathComponent:fileName];
                                                                      [data writeToURL:loacalUrl atomically:YES];
                                                                      completionHandler(loacalUrl);
                                                                  }
                                                              }];
    [task resume];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [self downloadAndSaveWithURL:[NSURL URLWithString:@"https://pic2.zhimg.com/80/v2-79c46a8b0a3098e72a0d211975acd46e_hd.jpg"] completionHandler:^(NSURL *url) {
//        NSLog(@"url");
//    }];
    [self registerNotificationCategory];
    [self registerRemoteNotification];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
