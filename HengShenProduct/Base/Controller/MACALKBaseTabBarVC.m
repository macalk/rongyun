//
//  MACBaseViewController.m
//  我的日记
//
//  Created by 鲁振 on 2019/4/8.
//  Copyright © 2019 鲁振. All rights reserved.
//

#import "MACALKBaseTabBarVC.h"
#import "MACALKBaseNAVC.h"
#import "TalkListVC.h"
#import "AddressVC.h"
#import "PanVC.h"
#import "FoundVC.h"
#import "MineVC.h"
#import "LZTabBar.h"

@interface MACALKBaseTabBarVC ()<UITabBarControllerDelegate,MyTabBarDelegate>

@property (nonatomic,strong)LZTabBar *mainTabBar;

@end

@implementation MACALKBaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    self.delegate = self;
    [self configTabBar];
    
//    //创建自定义TabBar
//    LZTabBar *myTabBar = [[LZTabBar alloc] init];
//    myTabBar.myTabBarDelegate = self;
//
//    //利用KVC替换默认的TabBar
//    [self setValue:myTabBar forKey:@"tabBar"];
    
}

#pragma mark - MyTabBarDelegate
-(void)addButtonClick:(LZTabBar *)tabBar
{
    PanVC *panvc = [[PanVC alloc]init];
    MACALKBaseNAVC *panNav = [[MACALKBaseNAVC alloc]initWithRootViewController:panvc];
    [self addChildViewController:panNav];
    tabBar.addLabel.textColor = Tab_Color_Selected;
}

- (void)configTabBar {
    
    TalkListVC *homevc = [[TalkListVC alloc]init];
    MACALKBaseNAVC *homeNav = [[MACALKBaseNAVC alloc]initWithRootViewController:homevc];
    homeNav.tabBarItem.title = @"聊天";
    homeNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon_default_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_pressed_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Normal} forState:UIControlStateNormal];
    [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Selected} forState:UIControlStateSelected];
    [self addChildViewController:homeNav];
    
    AddressVC *Addressvc = [[AddressVC alloc]init];
    MACALKBaseNAVC *addressNav = [[MACALKBaseNAVC alloc]initWithRootViewController:Addressvc];
    addressNav.tabBarItem.title = @"通讯录";
    addressNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon_default_contacts"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    addressNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_pressed_contacts-"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [addressNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Normal} forState:UIControlStateNormal];
    [addressNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Selected} forState:UIControlStateSelected];
    [self addChildViewController:addressNav];
    
    
    FoundVC *foundvc = [[FoundVC alloc]init];
    MACALKBaseNAVC *foundNav = [[MACALKBaseNAVC alloc]initWithRootViewController:foundvc];
    foundNav.tabBarItem.title = @"探索";
    foundNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon_default_find"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    foundNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_pressed_find"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [foundNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Normal} forState:UIControlStateNormal];
    [foundNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Tab_Color_Selected} forState:UIControlStateSelected];
    [self addChildViewController:foundNav];
    
    MineVC *minevc = [[MineVC alloc]init];
    MACALKBaseNAVC *mineNav = [[MACALKBaseNAVC alloc]initWithRootViewController:minevc];
    mineNav.tabBarItem.title = @"我的";
    mineNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_icon_default_contacts"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_pressed_mine"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
