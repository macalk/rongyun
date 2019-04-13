//
//  MACBaseViewController.m
//  我的日记
//
//  Created by 鲁振 on 2019/4/8.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import "MACALKBaseTabBarVC.h"
#import "MACALKBaseNAVC.h"
#import "HomeVC.h"
#import "TalkListVC.h"
#import "AddressVC.h"
#import "PanVC.h"
#import "FoundVC.h"
#import "MineVC.h"

@interface MACALKBaseTabBarVC ()<UITabBarControllerDelegate>

@end

@implementation MACALKBaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    self.delegate = self;
    [self configTabBar];
}

- (void)configTabBar {
    
    TalkListVC *homevc = [[TalkListVC alloc]init];
    MACALKBaseNAVC *homeNav = [[MACALKBaseNAVC alloc]initWithRootViewController:homevc];
    homeNav.tabBarItem.title = @"哆众";
    homeNav.tabBarItem.image = [[UIImage imageNamed:@"bottom_icon_home2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_icon_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Normal} forState:UIControlStateNormal];
    [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Selected} forState:UIControlStateSelected];
    [self addChildViewController:homeNav];
    
    AddressVC *Addressvc = [[AddressVC alloc]init];
    MACALKBaseNAVC *addressNav = [[MACALKBaseNAVC alloc]initWithRootViewController:Addressvc];
    addressNav.tabBarItem.title = @"通讯录";
    addressNav.tabBarItem.image = [[UIImage imageNamed:@"bottom_icon_recom2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    addressNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_icon_recom"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [addressNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Normal} forState:UIControlStateNormal];
    [addressNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Selected} forState:UIControlStateSelected];
    [self addChildViewController:addressNav];
    
    PanVC *panvc = [[PanVC alloc]init];
    MACALKBaseNAVC *panNav = [[MACALKBaseNAVC alloc]initWithRootViewController:panvc];
    panNav.tabBarItem.title = @"盘Ta";
    panNav.tabBarItem.image = [[UIImage imageNamed:@"bottom_icon_me2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    panNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [panNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Normal} forState:UIControlStateNormal];
    [panNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Selected} forState:UIControlStateSelected];
    [self addChildViewController:panNav];
    
    FoundVC *foundvc = [[FoundVC alloc]init];
    MACALKBaseNAVC *foundNav = [[MACALKBaseNAVC alloc]initWithRootViewController:foundvc];
    foundNav.tabBarItem.title = @"发现";
    foundNav.tabBarItem.image = [[UIImage imageNamed:@"bottom_icon_me2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    foundNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [foundNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Normal} forState:UIControlStateNormal];
    [foundNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Selected} forState:UIControlStateSelected];
    [self addChildViewController:foundNav];
    
    MineVC *minevc = [[MineVC alloc]init];
    MACALKBaseNAVC *mineNav = [[MACALKBaseNAVC alloc]initWithRootViewController:minevc];
    mineNav.tabBarItem.title = @"我的";
    mineNav.tabBarItem.image = [[UIImage imageNamed:@"bottom_icon_me2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"bottom_icon_me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [mineNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Normal} forState:UIControlStateNormal];
    [mineNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Selected} forState:UIControlStateSelected];
    [self addChildViewController:mineNav];
    
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    [self MACALKAnimateTabBarButton];
}

- (void)MACALKAnimateTabBarButton {
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            [imageView.layer addAnimation:animation forKey:nil];
            break;
        }
    }
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
