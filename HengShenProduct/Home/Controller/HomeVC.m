//
//  HomeVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "HomeVC.h"
#import "TalkListVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TalkListVC *vc = [[TalkListVC alloc]init];
    vc.view.frame = self.view.bounds;
    [self addChildViewController:vc];
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
