//
//  UIColor+StrColor.h
//  KaiXinQianDai
//
//  Created by xiaoning on 2018/11/26.
//  Copyright © 2018年 xiaoning. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (StrColor)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;

@end

