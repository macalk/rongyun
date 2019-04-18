//
//  MACALKBaseVC.m
//  我的日记
//
//  Created by 鲁振 on 2019/4/8.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import "MACALKBaseVC.h"

@interface MACALKBaseVC ()

@end

@implementation MACALKBaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNavigationBarShadow:[UIImage new]];
    [self configNavigationBarImage:[UIImage imageWithColor:MACALKHexColor(@"#ECEDEE")]];
}

- (void)configStatusBarDefault {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)configStatusBarLight {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)configNavigationBarHidden {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)configNavigationBarShow {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)configNavigationBarImage:(UIImage *)image {
    //    [self configNavigationBarShow];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)configNavigationBarShadow:(UIImage *)image {
    //    [self configNavigationBarShow];
    [self.navigationController.navigationBar setShadowImage:image];
}

- (void)configNavigationBarTitleWithColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:MACALKFont(18)}];
}

- (void)configDefaultLeftBarButton {
    if (self.navigationController.viewControllers && [self.navigationController.viewControllers firstObject] != self) {
        [self configLeftBarButtonWithImage:@"icon_return_black" Title:nil];
    }
}

- (void)configDefaultLeftBarButtonWithTitle:(NSString *)title {
    [self configLeftBarButtonWithImage:@"icon_return_black" Title:title];
}

- (void)configLeftBarButtonWithImage:(NSString *)image Title:(NSString *)title {
    NSMutableArray *buttonItems = [NSMutableArray array];
    if (!NULLString(image) && NULLString(title)) {
        UIImage *btnImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:btnImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAciton)];
        [buttonItems addObject:item];
    }else if (!NULLString(title) && NULLString(image)) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAciton)];
        [buttonItems addObject:item];
    }else if (!NULLString(title) && !NULLString(image)) {
        UIImage *btnImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:btnImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAciton)];
        [buttonItems addObject:item];
        UIBarButtonItem *itemT = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAciton)];
        [itemT setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} forState:UIControlStateNormal];
        [buttonItems addObject:itemT];
    }
    self.navigationItem.leftBarButtonItems = buttonItems;
}

- (void)configRightBarButtonWithImage:(NSString *)image Title:(NSString *)title {
    NSMutableArray *buttonItems = [NSMutableArray array];
    if (!NULLString(image) && NULLString(title)) {
        UIImage *btnImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:btnImage style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAciton)];
        [buttonItems addObject:item];
    }else if (!NULLString(title) && NULLString(image)) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAciton)];
        [buttonItems addObject:item];
    }else if (!NULLString(title) && !NULLString(image)) {
        UIImage *btnImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:btnImage style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAciton)];
        [buttonItems addObject:item];
        UIBarButtonItem *itemT = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAciton)];
        [buttonItems addObject:itemT];
    }
    self.navigationItem.rightBarButtonItems = buttonItems;
}

- (void)leftBarButtonAciton {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)rightBarButtonAciton {
    
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
