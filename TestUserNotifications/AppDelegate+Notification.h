//
//  AppDelegate+Notification.h
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/5.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>




@interface AppDelegate (Notification)<UNUserNotificationCenterDelegate>
- (void)registerNotification;
- (void)registerNotificationCategory;
@end
