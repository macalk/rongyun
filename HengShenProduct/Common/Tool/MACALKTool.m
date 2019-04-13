//
//  MACALKTool.m
//  我的日记
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import "MACALKTool.h"

@implementation MACALKTool

+ (UIViewController *)getViewController {
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    if (tabBarController && [tabBarController isKindOfClass:[UITabBarController class]]) {
        UINavigationController *navigationController = (UINavigationController *)tabBarController.selectedViewController;
        if (navigationController && [navigationController isKindOfClass:[UINavigationController class]]) {
            UIViewController *controller = navigationController.visibleViewController;
            return controller;
        }
    }
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

+ (void)pushLogin {
//    LoginViewController *vc = [[LoginViewController alloc]init];
//    [[self getViewController].navigationController pushViewController:vc animated:YES];
}

+ (void)jumpLogin {
//    [self jumpLoginWithSuccessBlock:nil];
}

//+ (void)jumpLoginWithSuccessBlock:(LoginSuccessBlock)successBlock {
//    if ([MACALKHandle shareHandle].isLogin) {
//        return;
//    }
//    UIViewController *controller = [self getViewController];
//    if ([controller isKindOfClass:[LoginViewController class]]) {
//        return;
//    }
//    LoginViewController *loginVC = [[LoginViewController alloc] initWithSuccessBlock:successBlock];
//    BMBaseNavigationController *navVC = [[BMBaseNavigationController alloc] initWithRootViewController:loginVC];
//    [controller.navigationController presentViewController:navVC animated:YES completion:nil];
    
//}

+ (void)jumpWebWithUrl:(NSString *)url {
//    BMBaseWebViewController *webVC = [[BMBaseWebViewController alloc] init];
//    webVC.url = url;
//    [[self getViewController].navigationController pushViewController:webVC animated:YES];
}

//+ (NSString *)getHTMLWithPath:(NSString *)path {
//    if (![path containsString:@"?"]) {
//        path = [path stringByAppendingString:@"?"];
//    }
//    NSString *htmlUrl = [BaseHTMLUrl stringByAppendingString:path];
//    return htmlUrl;
//}

+ (CGFloat)getTextWidthWithText:(NSString *)text font:(UIFont *)font {
    return [self getTextWidthWithText:text font:font wordSpace:-1];
}

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    return [self getTextHeightWithText:text font:font wordSpace:-1 lineSpace:-1 width:width];
}

+ (CGFloat)getTextWidthWithText:(NSString *)text font:(UIFont *)font wordSpace:(CGFloat)wordSpace {
    NSDictionary *dic = @{NSFontAttributeName:font};
    if (wordSpace >= 0) {
        dic = @{NSKernAttributeName:@(wordSpace), NSFontAttributeName:font};
    }
    CGFloat width = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.width;
    return width;
}

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace width:(CGFloat)width {
    return [self getTextHeightWithText:text font:font wordSpace:-1 lineSpace:lineSpace width:width];
}

+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font wordSpace:(CGFloat)wordSpace lineSpace:(CGFloat)lineSpace width:(CGFloat)width {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *dic = @{NSFontAttributeName:font};
    if (wordSpace >= 0) {
        dic = @{NSKernAttributeName:@(wordSpace), NSFontAttributeName:font};
    }
    else if (lineSpace >= 0) {
        dic = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:font};
    }
    else if (wordSpace >= 0 && lineSpace >= 0) {
        dic = @{NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@(wordSpace), NSFontAttributeName:font};
    }
    CGFloat height = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}

+ (NSMutableAttributedString *)getText:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace {
    return [self getText:text font:font wordSpace:-1 lineSpace:lineSpace];
}

+ (NSMutableAttributedString *)getText:(NSString *)text font:(UIFont *)font wordSpace:(CGFloat)wordSpace lineSpace:(CGFloat)lineSpace {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *dic = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:font};
    if (wordSpace >= 0) {
        dic = @{NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@(wordSpace), NSFontAttributeName:font};
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:dic];
    return string;
}

+ (NSString *)getFixPhone:(NSString *)phone {
    if (phone.length == 11) {
        phone = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return phone;
}

//+ (NSString *)getUUID {
//    NSString * strUUID = (NSString *)[KeyChainStore load:UUID_CacheKey];
//    if ([strUUID isEqualToString:@""] || !strUUID) {
//        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
//        CFRelease(uuidRef);
//        [KeyChainStore save:UUID_CacheKey data:strUUID];
//    }
//    return strUUID;
//}

+ (NSString *)getTime:(NSInteger)seconds {
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", seconds/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (seconds%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld", seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@", str_hour, str_minute, str_second];
    return format_time;
}

+ (NSString *)dictionaryToJsonString:(NSDictionary *)dic {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (BOOL)isHaveEmptyString:(NSString *)str {
    NSRange range = [str rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

//+(NSString *)getHtmlSuffix {
//    return [NSString stringWithFormat:@"version=%@&platform=IOS&deviceId=%@&appKey=%@&appMarket=_ios",AppVersion,[BMTool getUUID],BundleID];
//}

+(NSString *)getNowTimeTimes{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
}

//字符串转时间 （例如：2018-12-14 13:27:25）
+ (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,（精确到毫秒需要*1000）
    return timeStr;
}

// 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    //第一代身份证正则表达式(15位)
    NSString *isIDCard1 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    //第二代身份证正则表达式(18位)
    NSString *isIDCard2 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[A-Z])$";
    //    NSString *pattern = @(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$);
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isIDCard1];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isIDCard2];
    
    BOOL isMatch1 = [pred1 evaluateWithObject:idCard];
    BOOL isMatch2 = [pred2 evaluateWithObject:idCard];
    
    if (isMatch1 || isMatch2) {
        return true;
    }
    return false;
}

#pragma mark - 判断是否为电话号码
+ (BOOL)isPhoneNumber:(NSString *)number
{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:number];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:number];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:number];
    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
}

//(view转Image)使用该方法不会模糊，根据屏幕密度计算
+ (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}


@end
