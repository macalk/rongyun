//
//  MACALKHandle.m
//  我的日记
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import "MACALKHandle.h"

@implementation MACALKHandle

+ (instancetype)shareHandle {
    static MACALKHandle *handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[MACALKHandle alloc] init];
    });
    return handle;
}

@end
