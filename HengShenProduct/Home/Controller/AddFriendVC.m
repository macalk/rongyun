//
//  AddFriendVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/11.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "AddFriendVC.h"
#import "AddFriendSearchView.h"

@interface AddFriendVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AddFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configDefaultLeftBarButtonWithTitle:@"添加好友"];
    [self configView];
}

- (void)configView {
    
    UIView *tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    AddFriendSearchView *searchView = [[AddFriendSearchView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    
    CommonLabel *idLabel = [[CommonLabel alloc]initWithText:@"我的ID：****" font:16 textColor:@"#828384"];
    idLabel.frame = CGRectMake(0, 60, ScreenWidth, 50);
    idLabel.backgroundColor = MACALKHexColor(@"#ECEDEE");
    idLabel.textAlignment = NSTextAlignmentCenter;
    
    [tableHeadView addSubview:searchView];
    [tableHeadView addSubview:idLabel];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = tableHeadView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = MACALKHexColor(@"#ECEDEE");
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.detailTextLabel.textColor = MACALKHexColor(@"#8D8E8F");
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"icon_sys"];
        cell.textLabel.text = @"扫一扫";
        cell.detailTextLabel.text = @"扫描二维码名片";
    }else {
        cell.imageView.image = [UIImage imageNamed:@"icon_tjlxr"];
        cell.textLabel.text = @"手机联系人";
        cell.detailTextLabel.text = @"添加或邀请通讯录中的朋友";
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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
