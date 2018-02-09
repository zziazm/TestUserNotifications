//
//  MeidaViewController.m
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/8.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "MeidaViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface MeidaViewController ()

@end

@implementation MeidaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)postNotification:(id)sender {
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"带图片的通知";
    content.body = @"显示了一张图片";
    NSURL * imageURL = [[NSBundle mainBundle] URLForResource:@"timor" withExtension:@"png"];
    NSError *error;
    UNNotificationAttachment * attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachment" URL:imageURL options:nil error:&error];
    if (!error) {
        content.attachments = @[attachment];
    }
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:false];
    
    NSString *requestIdentifier = @"media";

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
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
