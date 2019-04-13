//
//  RequestDefine.h
//  我的日记
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef RequestDefine_h
#define RequestDefine_h

#ifdef DEBUG

#define BaseUrl @"http://hs.jiongxin.cn/mobile/" //开发环境

#else

#define BaseUrl @"http://hs.jiongxin.cn/mobile/" //发布环境

#endif

static NSString * const groupId = @"1";

#endif /* RequestDefine_h */
