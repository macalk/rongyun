//
//  AddressHeadView.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/17.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "AddressHeadView.h"


@implementation AddressHeadView

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
    
    NSArray *imgArr = @[@"contacts_icon_add",@"contacts_icon_group",@"contacts_icon_public"];
    NSArray *titArr = @[@"新的朋友",@"群聊",@"公众号"];
    
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 10+i;
        btn.frame = CGRectMake(ScreenWidth/3*i, 0, ScreenWidth/3, self.bounds.size.height);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imgArr[i]]]];
        [btn addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.centerY.equalTo(btn).with.offset(-20);
            make.size.mas_offset(CGSizeMake(50, 50));
        }];
        
        UILabel *tit = [[UILabel alloc]init];
        tit.text = [NSString stringWithFormat:@"%@",titArr[i]];
        tit.font = [UIFont systemFontOfSize:15];
        tit.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:tit];
        [tit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.top.equalTo(img.mas_bottom).with.offset(20);
        }];
        
    }
    
}

- (void)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            {
                
            }
            break;
        case 11:
        {
            
        }
            break;
        case 12:
        {
            
        }
            break;
            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
