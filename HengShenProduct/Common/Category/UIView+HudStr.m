//
//  UIView+HudStr.m
//  KaiXinQianDai
//
//  Created by xiaoning on 2018/11/27.
//  Copyright © 2018年 xiaoning. All rights reserved.
//

#import "UIView+HudStr.h"

@implementation UIView (HudStr)

+ (void)hudWithMessage:(NSString *)message {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setCornerRadius:4.f];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    if (message.length != 0) {
        [SVProgressHUD showImage:nil status:[@" " stringByAppendingString:message]];
    }
}

@end
