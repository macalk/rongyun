//
//  MACALKHandle.h
//  我的日记
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MACALKHandle : NSObject

+ (instancetype)shareHandle;

Assign BOOL isLogin;
Copy NSString *userId;
Copy NSString *userName;
Copy NSString *phone;
Copy NSString *token;

@end


