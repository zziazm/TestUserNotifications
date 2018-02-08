//
//  ViewController.m
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/5.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate+Notification.h"
#import "TimeIntervalViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *s = segue.identifier;
    if ([s isEqualToString:@"showTimeInterval"]) {
        TimeIntervalViewController *dVC = segue.destinationViewController;
        dVC.notificationType = UNtimeIntervalType;
    }
    
    if ([s isEqualToString:@"showTimeIntervalForeground"]) {
        TimeIntervalViewController *dVC = segue.destinationViewController;
        dVC.notificationType = UNtimeIntervalForegroundType;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
