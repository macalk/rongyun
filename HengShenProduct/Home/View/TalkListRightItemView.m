//
//  TalkListRightItemView.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/11.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "TalkListRightItemView.h"
#import "AddGroupChatVC.h"
#import "AddFriendVC.h"
#import "ScanVC.h"
#import "HelpVC.h"


@implementation TalkListRightItemView

-(void)openView {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    UIView *rightItemBgView = [[UIView alloc]initWithFrame:window.bounds];
    rightItemBgView.backgroundColor = [UIColor clearColor];
    [window addSubview:rightItemBgView];
    self.rightItemBgView = rightItemBgView;
    
    UIImageView *openView = [[UIImageView alloc]initWithImage:MACALKImage(@"home_add_pressed_bg")];
    openView.userInteractionEnabled = YES;
    openView.frame = CGRectMake(ScreenWidth-180, TopBarHeight-5, 170, 232);
    [rightItemBgView addSubview:openView];
    
    NSArray *imgArr = @[@"home_icon_more_message",@"home_icon_more_add",@"home_icon_more_sys",@"home_icon_more_help"];
    NSArray *titArr = @[@"发起群聊",@"添加好友",@"扫一扫",@"帮助"];
    
    for (int i = 0; i<4; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.frame = CGRectMake(0, i*232/4, 170, 232/4);
        itemBtn.tag = 10+i;
        [openView addSubview:itemBtn];
        
        UIImageView *icomImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imgArr[i]]]];
        [itemBtn addSubview:icomImg];
        [icomImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemBtn);
            make.left.equalTo(itemBtn).with.offset(18);
        }];
        
        CommonLabel *icomLabel = [[CommonLabel alloc]initWithText:[NSString stringWithFormat:@"%@",titArr[i]] font:17 textColor:@"ffffff"];
        [itemBtn addSubview:icomLabel];
        [icomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(itemBtn);
            make.left.equalTo(icomImg.mas_right).with.offset(18);
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = MACALKHexColor(@"#5E5F60");
        [itemBtn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icomLabel);
            make.right.equalTo(itemBtn);
            make.bottom.equalTo(itemBtn);
            make.height.mas_equalTo(@0.5);
        }];
    }
}

- (void)itemBtnClick:(UIButton *)sender {
    
    [self.rightItemBgView removeFromSuperview];
    
    UIViewController *vc = [[UIViewController alloc]init];
    switch (sender.tag) {
        case 10:vc = [[AddGroupChatVC alloc]init];
        break;
        case 11:vc = [[AddFriendVC alloc]init];
        break;
        case 12:vc = [[ScanVC alloc]init];
        break;
        case 13:vc = [[HelpVC alloc]init];
        break;
        default:
        break;
    }
    [[MACALKTool getViewController].navigationController pushViewController:vc animated:YES];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
