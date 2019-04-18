//
//  LZTabBar.h
//  HengShenProduct
//
//  Created by 落定 on 2019/4/16.
//  Copyright © 2019 macalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZTabBar;

 //MyTabBar的代理必须实现addButtonClick，以响应中间“+”按钮的点击事件
@protocol MyTabBarDelegate <NSObject>
 -(void)addButtonClick:(LZTabBar *)tabBar;

@end

@interface LZTabBar : UITabBar

@property (nonatomic,weak) UILabel *addLabel;
@property (nonatomic,weak) id<MyTabBarDelegate> myTabBarDelegate;

@end


