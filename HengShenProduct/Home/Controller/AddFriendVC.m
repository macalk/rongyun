//
//  AddFriendVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/11.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "AddFriendVC.h"

@interface AddFriendVC ()

@end

@implementation AddFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加好友";
    
    [self configView];
}

- (void)configView {
    
    UILabel *tit = [[UILabel alloc]init];
    tit.text = @"+86";
    tit.font = [UIFont systemFontOfSize:15];
    tit.textColor = [UIColor blackColor];
    [self.view addSubview:tit];
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(100);
        make.left.equalTo(self.view).with.offset(30);
        make.size.mas_offset(CGSizeMake(40, 15));
    }];
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = @"请输入手机号";
    textField.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tit.mas_right).with.offset(5);
        make.centerY.equalTo(tit);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textField).with.offset(3);
        make.left.equalTo(tit);
        make.right.equalTo(textField);
        make.height.mas_offset(@1);
    }];
    
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
