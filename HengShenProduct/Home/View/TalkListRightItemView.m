//
//  TalkListRightItemView.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/11.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "TalkListRightItemView.h"


@implementation TalkListRightItemView

-(void)openView {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    UIView *rightItemBgView = [[UIView alloc]initWithFrame:window.bounds];
    rightItemBgView.backgroundColor = [UIColor clearColor];
    [window addSubview:rightItemBgView];
    self.rightItemBgView = rightItemBgView;
    
    UIView *openView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-130, TopBarHeight, 120, 200)];
    [rightItemBgView addSubview:openView];
    
    UIButton *addFriend = [UIButton buttonWithType:UIButtonTypeCustom];
    addFriend.frame = CGRectMake(0, 0, 120, 50);
    addFriend.backgroundColor = [UIColor blackColor];
    [addFriend setTitle:@"添加好友" forState:normal];
    [addFriend setTitleColor:[UIColor whiteColor] forState:normal];
    [openView addSubview:addFriend];
    self.addFriendBtn = addFriend;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
