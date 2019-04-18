//
//  CommonLabel.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/16.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "CommonLabel.h"

@implementation CommonLabel

- (instancetype)initWithText:(NSString *)text
                        font:(CGFloat)font
                   textColor:(NSString *)color;
{
    self = [super init];
    if (self) {
        if (text) {
            self.text = text;
        }
        if (font) {
            self.font = [UIFont systemFontOfSize:font];
        }
        if (color) {
            self.textColor = MACALKHexColor(color);
        }
        
    }
    return self;
}

- (void)configLabel {
    
}

@end
