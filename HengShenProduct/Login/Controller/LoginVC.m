//
//  LoginVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/12.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "LoginVC.h"
#import "MACALKBaseTabBarVC.h"
#import "RCDRCIMDataSource.h"

@interface LoginVC ()<RCIMConnectionStatusDelegate>

Strong UITextField *username;
Strong UITextField *password;

Strong NSString *loginUserName;
Strong NSString *loginUserId;
Strong NSString *loginToken;
Strong NSString *loginPassword;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configView];
    
}

- (void)configView {
    
    UITextField *username = [[UITextField alloc]init];
    username.placeholder = @"请输入账号";
    username.text = @"17681808382";
    username.font = [UIFont systemFontOfSize:15];
    username.textColor = [UIColor blackColor];
    username.backgroundColor = [UIColor grayColor];
    [self.view addSubview:username];
    [username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(100);
        make.size.mas_offset(CGSizeMake(ScreenWidth-100, 30));
    }];
    self.username = username;
    
    UITextField *password = [[UITextField alloc]init];
    password.placeholder = @"请输入密码";
    password.text = @"111111";
    password.font = [UIFont systemFontOfSize:15];
    password.textColor = [UIColor blackColor];
    password.backgroundColor = [UIColor grayColor];
    [self.view addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(username.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(ScreenWidth-100, 30));
    }];
    self.password = password;
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.backgroundColor = [UIColor blackColor];
    [login setTitle:@"登录" forState:normal];
    [login setTitleColor:[UIColor whiteColor] forState:normal];
    login.titleLabel.font = [UIFont systemFontOfSize:15];
    [login addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(password);
        make.top.equalTo(password.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(100, 40));
    }];
    
    UIButton *registered = [UIButton buttonWithType:UIButtonTypeCustom];
    registered.backgroundColor = [UIColor blackColor];
    [registered setTitle:@"注册" forState:normal];
    [registered setTitleColor:[UIColor whiteColor] forState:normal];
    registered.titleLabel.font = [UIFont systemFontOfSize:15];
    [registered addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registered];
    [registered mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(password);
        make.top.equalTo(password.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(100, 40));
    }];
    
    
}

//登录
- (void)loginBtn {
    
    [AFHttpTool loginWithUsername:self.username.text
                         password:self.password.text
                          success:^(id response) {
                              NSLog(@"%@",response[@"err_msg"]);
                              NSString *token = response[@"result"][@"token"];
                              NSString *userId = response[@"result"][@"user_id"];
                              [self loginRongCloud:self.username.text
                                          password:self.password.text
                                            userId:userId
                                             token:token];
                          } failure:^(NSError *err) {
                              NSLog(@"登录失败");
                          }];
}

//注册
- (void)registered {
    
    [AFHttpTool registerWithUsername:self.username.text
                                        password:self.password.text
                                         success:^(id response) {
                                             NSLog(@"注册成功>%@--%@",response,response[@"err_msg"]);
                                         } failure:^(NSError *err) {
                                             NSLog(@"注册失败>%@",err);
                                         }];
}

//登录融云
- (void)loginRongCloud:(NSString *)username
              password:(NSString *)password
                userId:(NSString *)userId
                 token:(NSString *)token {
    
    self.loginUserName = username;
    self.loginUserId = userId;
    self.loginToken = token;
    self.loginPassword = password;
    
    [[RCIM sharedRCIM] connectWithToken:token
                                success:^(NSString *userId) {
                                    
                                    //保存基本信息、更新信息
                                    self.loginUserId = userId;
                                    [self loginSuccess:username userId:userId token:token password:password];
                                    
                                } error:^(RCConnectErrorCode status) {
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        // SDK会自动重连登录，这时候需要监听连接状态
                                        [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
                                    });
                                    
                                } tokenIncorrect:^{
                                    
                                    NSLog(@"token获取失败，可以尝试调用获取token接口再次尝试");
                                    
                                }];
}

//保存用户信息
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
                        NSLog(@"%@",response);
                        if ([response[@"is_succ"] intValue] == 1) {
                            NSDictionary *result = response[@"result"];
                            NSString *nickname = result[@"user_name"];
                            NSString *portraitUri = result[@"headimg"];
                            RCUserInfo *user =
                            [[RCUserInfo alloc] initWithUserId:userId name:nickname portrait:portraitUri];
                            
                            //如果不存在头像使用默认头像URL
                            if (!user.portraitUri || user.portraitUri.length <= 0) {
                                user.portraitUri = @"http://pic69.nipic.com/file/20150608/9252150_134415115986_2.jpg";
                            }
                            /*保存到数据库
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

- (void)configTabBarRootViewController {
    MACALKBaseTabBarVC *tabBarVC = [[MACALKBaseTabBarVC alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tabBarVC;
    [window makeKeyWindow];
}

#pragma mark RCIMConnectionStatusDelegate SDK与融云服务器的连接状态发生变化时，会回调此方法。
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (status == ConnectionStatus_Connected) {
            [RCIM sharedRCIM].connectionStatusDelegate =
            (id<RCIMConnectionStatusDelegate>)[UIApplication sharedApplication].delegate;
            
            [self loginSuccess:self.loginUserName
                        userId:self.loginUserId
                         token:self.loginToken
                      password:self.loginPassword];
            
        } else if (status == ConnectionStatus_NETWORK_UNAVAILABLE) {
//            self.errorMsgLb.text = RCDLocalizedString(@"network_can_not_use_please_check");
        } else if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
//            self.errorMsgLb.text = RCDLocalizedString(@"accout_kicked");
        } else if (status == ConnectionStatus_TOKEN_INCORRECT) {
            NSLog(@"Token无效");
//            self.errorMsgLb.text = RCDLocalizedString(@"can_not_connect_server");
//            if (self.loginFailureTimes < 1) {
//                self.loginFailureTimes++;
//                [AFHttpTool getTokenSuccess:^(id response) {
//                    self.loginToken = response[@"result"][@"token"];
//                    self.loginUserId = response[@"result"][@"userId"];
//                    [self loginRongCloud:self.loginUserName
//                                  userId:self.loginUserId
//                                   token:self.loginToken
//                                password:self.loginPassword];
//                }
//                                    failure:^(NSError *err) {
//                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                            [hud hide:YES];
//                                            NSLog(@"Token无效");
//                                            self.errorMsgLb.text = RCDLocalizedString(@"can_not_connect_server");
//                                        });
//                                    }];
//            }
        } else {
            NSLog(@"RCConnectErrorCode is %zd", status);
        }
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
