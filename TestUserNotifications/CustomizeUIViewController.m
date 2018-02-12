//
//  CustomizeUIViewController.m
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/11.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "CustomizeUIViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface CustomizeUIViewController ()

@end

@implementation CustomizeUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}
- (IBAction)postNotification:(id)sender {
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"带图片的通知";
    content.body = @"你可以switch图片";
    NSURL * imageURL = [[NSBundle mainBundle] URLForResource:@"timor" withExtension:@"png"];
    UNNotificationAttachment * attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachment" URL:imageURL options:nil error:nil];
    
    NSURL * imageURL1 = [[NSBundle mainBundle] URLForResource:@"image" withExtension:@"JPG"];
    UNNotificationAttachment * attachment1 = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachment1" URL:imageURL1 options:nil error:nil];
    
    content.attachments = @[attachment, attachment1];
    
    content.userInfo =@{@"items":@[@{@"title":@"Photo 1", @"text":@"timor"}, @{@"title":@"Photo 2", @"text":@"good study"}]};
    
    // Set category to use customized UI, 这个要和你在plist文件里设置的UNNotificationExtensionCategory对应
    content.categoryIdentifier = @"customUI";
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:false];
    
    NSString *requestIdentifier = @"customUI";
    
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
