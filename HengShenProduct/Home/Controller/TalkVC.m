//
//  TalkVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "TalkVC.h"
#import "RCDUserInfoManager.h"


@implementation TalkVC

- (void)didTapCellPortrait:(NSString *)userId {
    NSLog(@"%lu",(unsigned long)self.conversationType);
    if (self.conversationType == ConversationType_GROUP || self.conversationType == ConversationType_DISCUSSION) {
        if (![userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
            [[RCDUserInfoManager shareInstance]
             getFriendInfo:userId
             completion:^(RCUserInfo *user) {
                 [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:user.userId];
                 [self gotoNextPage:user];
             }];
        } else {
            [[RCDUserInfoManager shareInstance]
             getUserInfo:userId
             completion:^(RCUserInfo *user) {
                 [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:user.userId];
                 [self gotoNextPage:user];
             }];
        }
    }
    if (self.conversationType == ConversationType_PRIVATE) {
        [[RCDUserInfoManager shareInstance] getUserInfo:userId
                                             completion:^(RCUserInfo *user) {
                                                 [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:user.userId];
                                                 [self gotoNextPage:user];
                                             }];
    }
    
    [self gotoNextPage:nil];
    
}

- (void)gotoNextPage:(RCUserInfo *)user {
    
    
//    NSArray *friendList = [[RCDataBaseManager shareInstance] getAllFriends];
//    BOOL isGotoDetailView = NO;
//    for (RCDUserInfo *friend in friendList) {
//        if ([user.userId isEqualToString:friend.userId] && [friend.status isEqualToString:@"20"]) {
//            isGotoDetailView = YES;
//        } else if ([user.userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
//            isGotoDetailView = YES;
//        }
//    }
//    if (isGotoDetailView == YES) {
//        RCDPersonDetailViewController *temp = [[RCDPersonDetailViewController alloc] init];
//        temp.userId = user.userId;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.navigationController pushViewController:temp animated:YES];
//        });
//    } else {
//        RCDAddFriendViewController *vc = [[RCDAddFriendViewController alloc] init];
//        vc.targetUserInfo = user;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.navigationController pushViewController:vc animated:YES];
//        });
//    }
}

@end
