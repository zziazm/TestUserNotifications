//
//  AuthorizationViewController.m
//  TestUserNotifications
//
//  Created by 赵铭 on 2018/2/6.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "AuthorizationViewController.h"
#import "AppDelegate+Notification.h"

@interface AuthorizationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *notificationCenterSettingLabel;
@property (weak, nonatomic) IBOutlet UILabel *soundSettingLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeSettingLabel;
@property (weak, nonatomic) IBOutlet UILabel *lockScreenLabel;
@property (weak, nonatomic) IBOutlet UILabel *AlertSettingLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPlaySettingLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertStyleSettingLabel;

@end

@implementation AuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _notificationCenterSettingLabel.text = [self uNNotificationSetting:settings.notificationCenterSetting];
            _soundSettingLabel.text = [self uNNotificationSetting:settings.soundSetting];
            _badgeSettingLabel.text = [self uNNotificationSetting:settings.badgeSetting];
            _lockScreenLabel.text  = [self uNNotificationSetting:settings.lockScreenSetting];
            _AlertSettingLabel.text = [self uNNotificationSetting:settings.alertSetting];
            _carPlaySettingLabel.text = [self uNNotificationSetting:settings.carPlaySetting];
            _alertStyleSettingLabel.text = [self alertStyle:settings.alertStyle];
            
        });
    }];
    // Do any additional setup after loading the view.
}

- (NSString *)uNNotificationSetting:(UNNotificationSetting)setting{
    switch (setting) {
        case UNNotificationSettingEnabled:
            return @"Enabled";
            break;
        case UNNotificationSettingDisabled:
            return @"Disabled";
            break;
        case UNNotificationSettingNotSupported:
            return @"NotSupported";
            break;
        default:
            break;
    }
}

- (NSString *)alertStyle:(UNAlertStyle)style{
    switch (style) {
        case UNAlertStyleNone:
            return @"None";
            break;
        case UNAlertStyleBanner:
            return @"Banner";
            break;
        case UNAlertStyleAlert:
            return @"Alert";
            break;
        default:
            break;
    }
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
