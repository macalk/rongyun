//
//  MethodDefine.h
//  我的日记
//
//  Created by 鲁振 on 2019/4/9.
//  Copyright © 2019 鲁振. All rights reserved.
//

#ifndef MethodDefine_h
#define MethodDefine_h

#define MACALKImage(name)                       [UIImage imageNamed:name]
#define MACALKString(string,args...)            [NSString stringWithFormat:string, args]
#define MACALKHexColor(string)                  [UIColor colorWithHexString:string]
#define MACALKHexColorAlpha(string, value)      [UIColor colorWithHexString:string alpha:value]
#define MACALKFont(size)                        [UIFont systemFontOfSize:size]
#define MACALKBoldFont(size)                    [UIFont boldSystemFontOfSize:size]
#define MACALKUrl(string)                       [NSURL URLWithString:string]
#define DEFAULTS                                [NSUserDefaults standardUserDefaults]


#define Strong                                  @property (nonatomic, strong)
#define Weak                                    @property (nonatomic, weak)
#define Copy                                    @property (nonatomic, copy)
#define Assign                                  @property (nonatomic, assign)


#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [string isEqualToString:@"(null)"])


#ifndef weakify
# define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#endif

#ifndef strongify
# define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#endif


#endif /* MethodDefine_h */
