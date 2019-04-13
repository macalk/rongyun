//
//  MACALKTool.h
//  我的日记
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MACALKTool : NSObject

+ (UIViewController *)getViewController;

+ (void)jumpLogin;

+ (void)pushLogin;

//+ (void)jumpLoginWithSuccessBlock:(LoginSuccessBlock)successBlock;

+ (void)jumpWebWithUrl:(NSString *)url;

//+ (NSString *)getHTMLWithPath:(NSString *)path;

+ (CGFloat)getTextWidthWithText:(NSString *)text font:(UIFont *)font;

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

+ (CGFloat)getTextWidthWithText:(NSString *)text font:(UIFont *)font wordSpace:(CGFloat)wordSpace;

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace width:(CGFloat)width;

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font wordSpace:(CGFloat)wordSpace lineSpace:(CGFloat)lineSpace width:(CGFloat)width;

+ (NSMutableAttributedString *)getText:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace;

+ (NSMutableAttributedString *)getText:(NSString *)text font:(UIFont *)font wordSpace:(CGFloat)wordSpace lineSpace:(CGFloat)lineSpace;

+ (NSString *)getFixPhone:(NSString *)phone;

+ (NSString *)getUUID;

+ (NSString *)getTime:(NSInteger)seconds;

+ (NSString *)getTimeStrWithString:(NSString *)str;

+ (NSString *)getNowTimeTimes;

+ (NSString *)dictionaryToJsonString:(NSDictionary *)dic;

+ (BOOL)isHaveEmptyString:(NSString *)str;

+ (BOOL)checkUserIdCard: (NSString *) idCard;

+ (BOOL)isPhoneNumber:(NSString *)number;

+ (NSString *)getHtmlSuffix;

+ (UIImage *)convertViewToImage:(UIView *)view;

@end


