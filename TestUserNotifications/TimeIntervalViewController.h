//
//  TimeIntervalViewController.h
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/7.
//  Copyright © 2018年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate+Notification.h"

typedef NS_ENUM(NSUInteger, UserNotificationType) {
    UNtimeIntervalType,
    UNtimeIntervalForegroundType,
};

@interface TimeIntervalViewController : UIViewController
@property (nonatomic, assign) UserNotificationType notificationType;
@end
