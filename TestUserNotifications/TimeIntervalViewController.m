//
//  TimeIntervalViewController.m
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/7.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "TimeIntervalViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface TimeIntervalViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;

@end

@implementation TimeIntervalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _timeTF.text = @"5";
    if (_notificationType == UNtimeIntervalType) {
        _descriptionLabel.text = @"你需要把应用退到后台才能看到这个通知";
    }else if (_notificationType == UNtimeIntervalForegroundType){
        _descriptionLabel.text = @"这个通知会在前台显示";
    }
    // Do any additional setup after loading the view.
}
- (IBAction)postNotification:(id)sender {
    NSTimeInterval time = [_timeTF.text doubleValue];
    // 1. 创建通知内容
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Time Interval Notification";
    content.body = @"My first notification";
    content.sound = [UNNotificationSound defaultSound];
    // 2. 创建发送触发
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:false];
    
    NSString *requestIdentifier = @"identifier";
    // 3. 发送请求标识符
    if (_notificationType == UNtimeIntervalType) {
        requestIdentifier = @"com.test.usernotification.timeInterval";
    }else if (_notificationType == UNtimeIntervalForegroundType){
        requestIdentifier = @"com.test.usernotification.timeIntervalForeground";
    }
    
    // 4. 创建一个发送请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    
    //将请求添加到发送中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Time Interval Notification scheduled: %@", requestIdentifier);
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
