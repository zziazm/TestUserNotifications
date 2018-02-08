//
//  AppDelegate+Notification.h
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/5.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
//enum UserNotificationType: String {
//case timeInterval
//case timeIntervalForeground
//case pendingRemoval
//case pendingUpdate
//case deliveredRemoval
//case deliveredUpdate
//case actionable
//case mutableContent
//case media
//case customUI
//}


typedef NS_ENUM(NSUInteger, UserNotificationType) {
    UNtimeIntervalType,
    UNtimeIntervalForegroundType,
};

@interface AppDelegate (Notification)<UNUserNotificationCenterDelegate>
- (void)registerRemoteNotification;
- (void)registerNotificationCategory;
@end
