//
//  NotificationViewController.m
//  NotificationContent
//
//  Created by 赵铭 on 2018/2/11.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationPresentItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSURL *url;

@end

@implementation NotificationPresentItem
@end


@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSInteger index;
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.backgroundColor = [UIColor redColor];
    self.items = @[].mutableCopy;
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
   UNNotificationContent *content = notification.request.content;
    NSArray * items = content.userInfo[@"items"];
    for (int i  = 0; i < items.count; i++) {
        NSDictionary *item = items[i];
        NSString *title = item[@"title"];
        NSString *text = item[@"text"];
        NSURL *url = content.attachments[i].URL;
        NotificationPresentItem *presentItem = [[NotificationPresentItem alloc] init];
        presentItem.title = title;
        presentItem.text = text;
        presentItem.url = url;
        [self.items addObject:presentItem];
    }
    [self updateUI:0];
    
    
}

- (void)updateUI:(NSInteger)idx{
    NotificationPresentItem *item = self.items[idx];
    
    if ([item.url startAccessingSecurityScopedResource]){
//              self.imageView.image = [UIImage imageWithContentsOfFile:item.url.path];
        NSData *imageData = [NSData dataWithContentsOfFile:item.url.path];
        UIImage *image = [UIImage imageWithData:imageData];
        self.imageView.image = image;
        [item.url stopAccessingSecurityScopedResource];

    }
    self.label.text = item.title;
    self.textview.text = item.text;
    self.index = idx;
    
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion{
    if ([response.actionIdentifier isEqualToString:@"switch"]) {
        NSInteger idx = 0;
        if (self.index == 0) {
            idx = 1;
        }else{
            idx = 0;
        }
        [self updateUI:idx];
        completion(UNNotificationContentExtensionResponseOptionDoNotDismiss);
    }else if ([response.actionIdentifier isEqualToString:@"open"]){
        completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
    }else if ([response.actionIdentifier isEqualToString:@"dismiss"]){
        completion(UNNotificationContentExtensionResponseOptionDismiss);
    }else{
        completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
    }
}

@end
