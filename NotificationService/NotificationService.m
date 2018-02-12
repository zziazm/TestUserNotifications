//
//  NotificationService.m
//  NotificationService
//
//  Created by 赵铭 on 2018/2/9.
//  Copyright © 2018年 zm. All rights reserved.
//

#import "NotificationService.h"
#import <CommonCrypto/CommonDigest.h>
@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService
//if let imageURLString = bestAttemptContent.userInfo["image"] as? String,
//let URL = URL(string: imageURLString)
//{
//    downloadAndSave(url: URL) { localURL in
//        if let localURL = localURL {
//            do {
//                let attachment = try UNNotificationAttachment(identifier: "image_downloaded", url: localURL, options: nil)
//                bestAttemptContent.attachments = [attachment]
//            } catch {
//                print(error)
//            }
//        }
//        contentHandler(bestAttemptContent)
//    }
//}

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    // Modify the notification content here...
    self.bestAttemptContent.body = [NSString stringWithFormat:@"%@ [已经修改了]", self.bestAttemptContent.body];
    if (self.bestAttemptContent.userInfo[@"image"]) {
//    NSDictionary *dict =  self.bestAttemptContent.userInfo;
//    NSDictionary *notiDict = dict[@"aps"];
//    NSString *imgUrl = [NSString stringWithFormat:@"%@",notiDict[@"imageAbsoluteString"]];
        NSString *imgUrl = self.bestAttemptContent.userInfo[@"image"];//[NSString stringWithFormat:@"%@", ];
        [self downloadAndSaveWithURL:[NSURL URLWithString:imgUrl] completionHandler:^(NSURL *localURL) {
            UNNotificationAttachment * attachment = [UNNotificationAttachment attachmentWithIdentifier:@"image_downloaded" URL:localURL options:nil error:nil];
            self.bestAttemptContent.attachments = @[attachment];
            self.contentHandler(self.bestAttemptContent);
        }];

  }
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}
- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return  output;
}

- (void)downloadAndSaveWithURL:(NSURL*)url
             completionHandler:(void(^)(NSURL *))completionHandler
{

    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                  if (data) {
                                                                      NSString *ret = url.absoluteString.pathExtension;
                                                                      NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
                                                                      NSURL *cacheUrl = [NSURL fileURLWithPath:cachePath];
                                                                      NSString *fileName = [[self md5:url.absoluteString] stringByAppendingPathExtension:ret];
                                                                      NSURL *loacalUrl = [cacheUrl URLByAppendingPathComponent:fileName];
                                                                      [data writeToURL:loacalUrl atomically:YES];
                                                                      completionHandler(loacalUrl);
                                                                  }
                                                              }];
    [task resume];

}


//
//private func downloadAndSave(url: URL, handler: @escaping (_ localURL: URL?) -> Void) {
//    let task = URLSession.shared.dataTask(with: url, completionHandler: {
//        data, res, error in
//
//        var localURL: URL? = nil
//
//        if let data = data {
//            let ext = (url.absoluteString as NSString).pathExtension
//            let cacheURL = URL(fileURLWithPath: FileManager.default.cachesDirectory)
//            let url = cacheURL.appendingPathComponent(url.absoluteString.md5).appendingPathExtension(ext)
//
//            if let _ = try? data.write(to: url) {
//                localURL = url
//            }
//        }
//
//        handler(localURL)
//    })
//
//    task.resume()
//}






//- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
//    self.contentHandler = contentHandler;
//    // copy发来的通知，开始做一些处理
//    self.bestAttemptContent = [request.content mutableCopy];
//
//    // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
//
//
//    // 重写一些东西
//    NSLog(@"didReceiveNotificationRequestaaaaa");
//    self.bestAttemptContent.title = @"我是标题mklklfsdfsafsafasfad";
//
//    // 附件
//    NSDictionary *dict =  self.bestAttemptContent.userInfo;
//    NSDictionary *notiDict = dict[@"aps"];
//    NSString *imgUrl = [NSString stringWithFormat:@"%@",notiDict[@"imageAbsoluteString"]];
//
//    // 这里添加一些点击事件，可以在收到通知的时候，添加，也可以在拦截通知的这个扩展中添加
//
//    self.bestAttemptContent.categoryIdentifier = @"category1";
//
//
//
//
//    if (!imgUrl.length) {
//
//        self.contentHandler(self.bestAttemptContent);
//
//    }
//
//
//
//    [self loadAttachmentForUrlString:imgUrl withType:@"png" completionHandle:^(UNNotificationAttachment *attach) {
//
//        if (attach) {
//            self.bestAttemptContent.attachments = [NSArray arrayWithObject:attach];
//        }
//        self.contentHandler(self.bestAttemptContent);
//
//    }];
//
//
//
//
//
//
//
//
//
//
//
//}
//
//- (void)serviceExtensionTimeWillExpire {
//    // Called just before the extension will be terminated by the system.
//    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
//    self.contentHandler(self.bestAttemptContent);
//}
//
//
//- (void)loadAttachmentForUrlString:(NSString *)urlStr
//                          withType:(NSString *)type
//                  completionHandle:(void(^)(UNNotificationAttachment *attach))completionHandler{
//
//
//    __block UNNotificationAttachment *attachment = nil;
//    NSURL *attachmentURL = [NSURL URLWithString:urlStr];
//    NSString *fileExt = [self fileExtensionForMediaType:type];
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    [[session downloadTaskWithURL:attachmentURL
//                completionHandler:^(NSURL *temporaryFileLocation, NSURLResponse *response, NSError *error) {
//                    if (error != nil) {
//                        NSLog(@"%@", error.localizedDescription);
//                    } else {
//                        NSFileManager *fileManager = [NSFileManager defaultManager];
//                        NSURL *localURL = [NSURL fileURLWithPath:[temporaryFileLocation.path stringByAppendingString:fileExt]];
//                        [fileManager moveItemAtURL:temporaryFileLocation toURL:localURL error:&error];
//
//                        NSError *attachmentError = nil;
//                        attachment = [UNNotificationAttachment attachmentWithIdentifier:@"" URL:localURL options:nil error:&attachmentError];
//                        if (attachmentError) {
//                            NSLog(@"%@", attachmentError.localizedDescription);
//                        }
//                    }
//
//                    completionHandler(attachment);
//
//
//                }] resume];
//
//
//
//}
//- (NSString *)fileExtensionForMediaType:(NSString *)type {
//    NSString *ext = type;
//
//
//    if ([type isEqualToString:@"image"]) {
//        ext = @"jpg";
//    }
//
//    if ([type isEqualToString:@"video"]) {
//        ext = @"mp4";
//    }
//
//    if ([type isEqualToString:@"audio"]) {
//        ext = @"mp3";
//    }
//
//    return [@"." stringByAppendingString:ext];
//}

@end
