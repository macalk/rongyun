//
//  TalkListVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "TalkListVC.h"
#import "TalkVC.h"
#import "TalkListRightItemView.h"
#import "AddFriendVC.h"

@interface TalkListVC ()

@end

@implementation TalkListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"会话";
    [self configView];
    
    
}

- (void)configView {
    
    self.conversationListTableView.tableFooterView = [UIView new];
    [self configRightItem];
    [self configTalkType];
}

- (void)configRightItem {
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:MACALKImage(@"my_icon_set") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(moreItemPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
}

- (void)moreItemPress {
    TalkListRightItemView *rightItem = [[TalkListRightItemView alloc]init];
    [rightItem openView];
    [rightItem.addFriendBtn addTarget:self action:@selector(addFriendClick:) forControlEvents:UIControlEventTouchUpInside];

    UITapGestureRecognizer *rightItemBgtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightItemBgtap:)];
    [rightItem.rightItemBgView addGestureRecognizer:rightItemBgtap];

}

- (void)rightItemBgtap:(UIGestureRecognizer *)tap {
    [tap.view removeFromSuperview];
}

//添加好友
- (void)addFriendClick:(UIButton *)sender {
    [sender.superview.superview removeFromSuperview];
    AddFriendVC *vc = [[AddFriendVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)configTalkType {
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    
    //新建一个聊天会话View Controller对象,建议这样初始化
    //设置会话的类型，如单聊、群聊、聊天室、客服、公众服务会话等
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，群聊、聊天室为会话的ID）
    TalkVC *chat = [[TalkVC alloc] initWithConversationType:model.conversationType
targetId:model.targetId];
    //设置聊天会话界面要显示的标题
    chat.title = model.conversationTitle;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
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
