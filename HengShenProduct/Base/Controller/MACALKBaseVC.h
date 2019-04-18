//
//  MACALKBaseVC.h
//  我的日记
//
//  Created by 鲁振 on 2019/4/8.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MACALKBaseVC : UIViewController

- (void)configStatusBarDefault;
- (void)configStatusBarLight;
- (void)configNavigationBarHidden;
- (void)configNavigationBarShow;
- (void)configNavigationBarImage:(UIImage *)image;
- (void)configNavigationBarShadow:(UIImage *)image;
- (void)configNavigationBarTitleWithColor:(UIColor *)color;
- (void)configDefaultLeftBarButton;
- (void)configDefaultLeftBarButtonWithTitle:(NSString *)title;
- (void)configLeftBarButtonWithImage:(NSString *)image Title:(NSString *)title;
- (void)configRightBarButtonWithImage:(NSString *)image Title:(NSString *)title;

@end


