//
//  AppDelegate+Notification.m
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/5.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "AppDelegate+Notification.h"

@implementation AppDelegate (Notification)
- (void)registerRemoteNotification{
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        //请求使用本地和远程通知的权限
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
        }];
    }
}

#pragma mark -- UIApplicationDelegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"%@", error);
}

#pragma mark -- UNUserNotificationCenterDelegate
//通知交付给在前台的app时会调用这个方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    if ([notification.request.identifier isEqualToString:@"com.test.usernotification.timeInterval"]) {
        completionHandler(UNNotificationPresentationOptionNone);
    }
    else if ([notification.request.identifier isEqualToString:@"com.test.usernotification.timeIntervalForeground"] || [notification.request.identifier isEqualToString:@"actionable"]){
        completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    }else{
        completionHandler(UNNotificationPresentationOptionNone);

    }
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    NSString *categoryId = response.notification.request.content.categoryIdentifier;
    if ([categoryId isEqualToString:@"saySomething"]) {
        [self handleSaySomthing:response];
    }
    
}

#pragma mark -- Private

- (void)handleSaySomthing:(UNNotificationResponse *)response{
    NSString *actionId = response.actionIdentifier;
    NSString *text;
    if ([actionId isEqualToString:@"input"]) {
        text = ((UNTextInputNotificationResponse *)response).userText;
    }
    else if ([actionId isEqualToString:@"goodbye"]) {
        text = @"拜拜";
    }
    else if ([actionId isEqualToString:@"none"]) {
        text = @"";
    }
    else {
        text = @"";
    }
    if (text.length > 0) {
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"UserText" message:text delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [a show];
    }
    
}
//private func registerNotificationCategory() {
//    let saySomethingCategory: UNNotificationCategory = {
//        // 1
//        let inputAction = UNTextInputNotificationAction(
//                                                        identifier: "action.input",
//                                                        title: "Input",
//                                                        options: [.foreground],
//                                                        textInputButtonTitle: "Send",
//                                                        textInputPlaceholder: "What do you want to say...")
//
//        // 2
//        let goodbyeAction = UNNotificationAction(
//                                                 identifier: "action.goodbye",
//                                                 title: "Goodbye",
//                                                 options: [.foreground])
//
//        let cancelAction = UNNotificationAction(
//                                                identifier: "action.cancel",
//                                                title: "Cancel",
//                                                options: [.destructive])
//
//        // 3
//        return UNNotificationCategory(identifier:"saySomethingCategory", actions: [inputAction, goodbyeAction, cancelAction], intentIdentifiers: [], options: [.customDismissAction])
//    }()
//
//    UNUserNotificationCenter.current().setNotificationCategories([saySomethingCategory])
//}

- (void)registerNotificationCategory{
    UNNotificationCategory * (^saySomethingCategory)(void) = ^(){
        UNTextInputNotificationAction * inputAction = [UNTextInputNotificationAction actionWithIdentifier:@"input" title:@"Input" options:UNNotificationActionOptionForeground textInputButtonTitle:@"发送" textInputPlaceholder:@"说点什么"];
        UNNotificationAction * goodByeAction = [UNNotificationAction actionWithIdentifier:@"goodbye" title:@"Good bye" options:UNNotificationActionOptionForeground];
        UNNotificationAction * cancelAction = [UNNotificationAction actionWithIdentifier:@"none" title:@"Cancel" options:UNNotificationActionOptionDestructive];
        
        
       return [UNNotificationCategory categoryWithIdentifier:@"saySomething" actions:@[inputAction, goodByeAction, cancelAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    };
    
    UNNotificationCategory * (^customUICategory)(void) = ^(){
        UNNotificationAction *nextAction = [UNNotificationAction actionWithIdentifier:@"switch" title:@"Switch" options:UNNotificationActionOptionNone];
        
        UNNotificationAction *openAction = [UNNotificationAction actionWithIdentifier:@"open" title:@"Open" options:UNNotificationActionOptionForeground];
        
        UNNotificationAction *dismissAction = [UNNotificationAction actionWithIdentifier:@"dismiss" title:@"Dismiss" options:UNNotificationActionOptionDestructive];
        return [UNNotificationCategory categoryWithIdentifier:@"customUI" actions:@[nextAction, openAction, dismissAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    };
    
    [[UNUserNotificationCenter  currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:saySomethingCategory(), customUICategory(), nil]];
    
}
@end
