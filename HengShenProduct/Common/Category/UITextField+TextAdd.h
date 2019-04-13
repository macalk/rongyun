//
//  UITextField+TextAdd.h
//  KaiXinQianDai
//
//  Created by xiaoning on 2018/11/28.
//  Copyright © 2018年 xiaoning. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UITextField (TextAdd)

@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeholderColor;

- (NSString *)getSpecialSymbolsWithStr:(NSString *)string;

@end


