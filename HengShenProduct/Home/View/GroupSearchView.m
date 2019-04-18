//
//  GroupSearchView.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/17.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "GroupSearchView.h"

@interface GroupSearchView ()<UITextFieldDelegate>

Strong UIImageView *searchIcom;
Strong UITextField *textField;

@end

@implementation GroupSearchView

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
    self.textField.placeholder = @"搜索";
    self.textField.delegate = self;
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(self);
        make.left.equalTo(self.searchIcom.mas_right).with.offset(5);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = MACALKHexColor(@"#EAEBEC");
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(@0.5);
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.searchIcom.hidden = YES;
    [textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(self);
        make.left.equalTo(self).with.offset(5);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.searchIcom.hidden = NO;
    [textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(self);
        make.left.equalTo(self.searchIcom.mas_right).with.offset(5);
    }];
}

@end
