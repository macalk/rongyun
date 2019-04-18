//
//  AddFriendSearchView.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/18.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "AddFriendSearchView.h"

@interface AddFriendSearchView ()<UITextFieldDelegate>

Strong UIImageView *searchIcom;
Strong UITextField *textField;

@end

@implementation AddFriendSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configView];
    }
    return self;
}

- (void)configView {
    
    self.searchIcom = [[UIImageView alloc]initWithImage:MACALKImage(@"icon_search")];
    [self addSubview:self.searchIcom];
    [self.searchIcom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(21, 21));
    }];
    
    self.textField = [[UITextField alloc]init];
    self.textField.placeholder = @"用户ID/昵称";
    self.textField.delegate = self;
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(self);
        make.left.equalTo(self.searchIcom.mas_right).with.offset(10);
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
