//
//  AFHttpTool.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/11.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "AFHttpTool.h"
#import "AFHTTPSessionManager.h"

#define AFTimeOut 20

@implementation AFHttpTool

+ (AFHttpTool *)shareInstance {
    static AFHttpTool *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (void)requestWithMethod:(RequestMethodType)methodType
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure {
    
    
    //获得请求管理者
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:BaseUrl]];
    
    // 超时时间
    manager.requestSerializer.timeoutInterval = AFTimeOut;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    switch (methodType) {
        case RequestMethodTypeGet: {
            // GET请求
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        } break;
            
        case RequestMethodTypePost: {
            // POST请求
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
//                NSData * data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        } break;
            
        case RequestMethodTypePut: {
            [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                UIImage *image =[UIImage imageNamed:@"moon"];
                NSData *data = UIImagePNGRepresentation(image);
                
                
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                
                //上传
                /*
                 此方法参数
                 1. 要上传的[二进制数据]
                 2. 对应网站上[upload.php中]处理文件的[字段"file"]
                 3. 要保存在服务器上的[文件名]
                 4. 上传文件的[mimeType]
                 */
                [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                //上传进度
                // @property int64_t totalUnitCount;     需要下载文件的总大小
                // @property int64_t completedUnitCount; 当前已经下载的大小
                //
                // 给Progress添加监听 KVO
                NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                // 回到主队列刷新UI,用户自定义的进度条
                dispatch_async(dispatch_get_main_queue(), ^{
                    //self.progressView.progress = 1.0 *
                    //uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
                });
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        } break;
            
        default:
            break;
    }
        
}

//注册
+ (void)registerWithUsername:(NSString *)username
                   password:(NSString *)password
                    success:(void (^)(id))success
                    failure:(void (^)(NSError *))failure {
    
    NSDictionary *dic = @{@"username":username,@"password":password};
    [AFHttpTool requestWithMethod:RequestMethodTypePost
                              url:@"userapi.php?act=register"
                           params:dic
                          success:success
                          failure:failure];
}

//登录
+(void)loginWithUsername:(NSString *)username
                password:(NSString *)password
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    NSDictionary *dic = @{@"username":username,@"password":password};
    [AFHttpTool requestWithMethod:RequestMethodTypePost
                              url:@"userapi.php?act=login"
                           params:dic
                          success:success
                          failure:failure];
}

//获取用户信息
+ (void)getUserInfo:(NSString *)userId
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure {
    
    NSDictionary *dic = @{@"user_id":userId};
    [AFHttpTool requestWithMethod:RequestMethodTypePost
                              url:@"userapi.php?act=get_user_info"
                           params:dic
                          success:success
                          failure:failure];
}

@end
