//
//  AFHttpTool.h
//  HengShenProduct
//
//  Created by 落定 on 2019/4/11.
//  Copyright © 2019 macalk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethodType) { RequestMethodTypePost = 1, RequestMethodTypeGet = 2, RequestMethodTypePut = 3};

@interface AFHttpTool : NSObject

/**
 *  发送一个请求
 *
 *  @param methodType   请求方法
 *  @param url          请求路径
 *  @param params       请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)requestWithMethod:(RequestMethodType)methodType
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure;


//注册
+ (void)registerWithUsername:(NSString *)username
                   password:(NSString *)password
                    success:(void (^)(id response))success
                    failure:(void (^)(NSError *err))failure;

//登录
+ (void)loginWithUsername:(NSString *)username
                   password:(NSString *)password
                    success:(void (^)(id response))success
                    failure:(void (^)(NSError *err))failure;

//获取用户信息
+ (void)getUserInfo:(NSString *)userId
            success:(void (^)(id response))success
            failure:(void (^)(NSError *err))failure;

@end


