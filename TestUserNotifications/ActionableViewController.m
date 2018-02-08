//
//  ActionableViewController.m
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/7.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "ActionableViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface ActionableViewController ()

@end

@implementation ActionableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)postNotification:(id)sender {
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.body = @"说些什么吧";
    content.categoryIdentifier = @"saySomething";
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:false];
    NSString *requestIdentifier = @"actionable";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
