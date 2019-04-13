//
//  AppDelegate.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "AppDelegate.h"
#import "MACALKBaseTabBarVC.h"
#import "RCDRCIMDataSource.h"
#import "LoginVC.h"

@interface AppDelegate ()<RCIMConnectionStatusDelegate,RCIMReceiveMessageDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configKeyWindow];
    [self configThirdPart];
    
    return YES;
}

#pragma mark 配置根目录

- (void)configKeyWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
}

- (void)configTabBarRootViewController {
    MACALKBaseTabBarVC *tabBarVC = [[MACALKBaseTabBarVC alloc] init];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyWindow];
}

- (void)configLoginRootViewController {
    LoginVC *loginVC = [[LoginVC alloc]init];
    self.window.rootViewController = loginVC;
    [self.window makeKeyWindow];
}

#pragma mark 配置第三方

- (void)configThirdPart {
    [self configKeyBoard];
    [self configRong];
}

- (void)configKeyBoard {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)configRong {
    [[RCIM sharedRCIM] initWithAppKey:Rong_AppKey];
    
    
    //开启用户信息和群组信息的持久化
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    //设置用户信息源和群组信息源
    [RCIM sharedRCIM].userInfoDataSource = RCDDataSource;
    [RCIM sharedRCIM].groupInfoDataSource = RCDDataSource;
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList =
    @[ @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_GROUP) ];
    //开启多端未读状态同步
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    //IMKit连接状态的监听器
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    //群成员数据源
    [RCIM sharedRCIM].groupMemberDataSource = RCDDataSource;
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    
    //设置Log级别，开发阶段打印详细log
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
    
    
    //  设置头像为圆形
    //  [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    //  [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    //   设置优先使用WebView打开URL
    //  [RCIM sharedRCIM].embeddedWebViewPreferred = YES;
    
    
    [self connectRong];
}

//登录
- (void)connectRong {
    
    //登录
    NSString *token = [DEFAULTS objectForKey:@"userToken"];
    NSString *userId = [DEFAULTS objectForKey:@"userId"];
    NSString *userName = [DEFAULTS objectForKey:@"userName"];
    NSString *password = [DEFAULTS objectForKey:@"userPwd"];
    NSString *userNickName = [DEFAULTS objectForKey:@"userNickName"];
    NSString *userPortraitUri = [DEFAULTS objectForKey:@"userPortraitUri"];
    NSLog(@"%@-->%@",token,userPortraitUri);
    if (token.length && userId.length && password.length) {
        [self configTabBarRootViewController];
        
        //当前用户信息
        RCUserInfo *_currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:userNickName portrait:userPortraitUri];
        [RCIM sharedRCIM].currentUserInfo = _currentUserInfo;
        
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            
            //登录后台
            [AFHttpTool loginWithUsername:userName
                                 password:password
                                  success:^(id response) {
                                      //成功->根据userId获取用户信息
                                      
                                      //同步群组
                                      [RCDDataSource syncGroups];
                                      [RCDDataSource syncFriendList:userId
                                                           complete:^(NSMutableArray *result){
                                                           }];
            } failure:^(NSError *err) {
                //失败->展示错误信息
            }];
            
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
            
            //查询后台分组、展示数据
            [RCDDataSource syncGroups];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self configTabBarRootViewController];
            });
            
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
            
            //重新登录后台获取最新token
            [AFHttpTool loginWithUsername:userName
                                 password:password
                                  success:^(id response) {
                                      
                                      NSString *newToken = response[@"result"][@"token"];
                                      NSString *newUserId = response[@"result"][@"id"];
                                      
                                      //重新登录融云
                                      [[RCIM sharedRCIM] connectWithToken:newToken success:^(NSString *userId) {
                                          
                                          //保存基本信息、更新信息
                                          [self loginSuccess:userName userId:newUserId token:newToken password:password];
                                          
                                      } error:^(RCConnectErrorCode status) {
                                          
                                          //查询后台分组、展示数据
                                          [RCDDataSource syncGroups];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self configTabBarRootViewController];
                                          });
                                          
                                      } tokenIncorrect:^{
                                          [self gotoLoginViewAndDisplayReasonInfo:@"无法连接到服务器"];
                                      }];
                                      
                                  } failure:^(NSError *err) {
                                      [self gotoLoginViewAndDisplayReasonInfo:@"手机号或密码错误"];
                                  }];
        }];
        
    }else {
        [self configLoginRootViewController];
    }
    
}

- (void)loginSuccess:(NSString *)userName
              userId:(NSString *)userId
               token:(NSString *)token
            password:(NSString *)password {
    //保存默认用户
    [DEFAULTS setObject:userName forKey:@"userName"];
    [DEFAULTS setObject:password forKey:@"userPwd"];
    [DEFAULTS setObject:token forKey:@"userToken"];
    [DEFAULTS setObject:userId forKey:@"userId"];
    [DEFAULTS synchronize];
    
    //保存“发现”的信息
    /*[RCDHTTPTOOL getSquareInfoCompletion:^(NSMutableArray *result) {
        [DEFAULTS setObject:result forKey:@"SquareInfoList"];
        [DEFAULTS synchronize];
    }];*/
    
    //获取用户最新信息
    [AFHttpTool getUserInfo:userId
                    success:^(id response) {
                        
                        if ([response[@"code"] intValue] == 200) {
                            NSDictionary *result = response[@"result"];
                            NSString *nickname = result[@"user_name"];
                            NSString *portraitUri = result[@"headimg"];
                            RCUserInfo *user =
                            [[RCUserInfo alloc] initWithUserId:userId name:nickname portrait:portraitUri];
                            
                            /*
                            如果不存在头像使用默认头像URL
                            if (!user.portraitUri || user.portraitUri.length <= 0) {
                                user.portraitUri = [RCDUtilities defaultUserPortrait:user];
                            }
                            保存到数据库
                            [[RCDataBaseManager shareInstance] insertUserToDB:user];
                            */
                            
                            [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
                            [RCIM sharedRCIM].currentUserInfo = user;
                            [DEFAULTS setObject:user.portraitUri forKey:@"userPortraitUri"];
                            [DEFAULTS setObject:user.name forKey:@"userNickName"];
                            [DEFAULTS synchronize];
                        }
                    }
                    failure:^(NSError *err){
                        
                    }];
    
    //同步群组
    [RCDDataSource syncGroups];
    [RCDDataSource syncFriendList:userId
                         complete:^(NSMutableArray *friends){
                         }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self configTabBarRootViewController];
    });
    
}
- (void)gotoLoginViewAndDisplayReasonInfo:(NSString *)reason {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:reason
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil, nil];
        ;
        [alertView show];
        [self configLoginRootViewController];
        
    });
}

#pragma mark RCIMConnectionStatusDelegate SDK与融云服务器的连接状态发生变化时，会回调此方法。

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert"
                                                        message:@"accout_kicked"
                                                       delegate:nil
                                              cancelButtonTitle:@"i_know"
                              
                                              otherButtonTitles:nil, nil];
        [alert show];
        [self configLoginRootViewController];
    } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
//        [AFHttpTool getTokenSuccess:^(id response) {
//            NSString *token = response[@"result"][@"token"];
//            [[RCIM sharedRCIM] connectWithToken:token
//                                        success:^(NSString *userId) {
//
//                                        }
//                                          error:^(RCConnectErrorCode status) {
//
//                                          }
//                                 tokenIncorrect:^{
//
//                                 }];
//        }
//                            failure:^(NSError *err){
//
//                            }];
    } else if (status == ConnectionStatus_DISCONN_EXCEPTION) {
        [[RCIMClient sharedRCIMClient] disconnect];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert"
                                                        message:@"Your_account_has_been_banned"
                              
                                                       delegate:nil
                                              cancelButtonTitle:@"i_know"
                              
                                              otherButtonTitles:nil, nil];
        [alert show];
        [self configLoginRootViewController];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
