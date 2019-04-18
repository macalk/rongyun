//
//  MineVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "MineVC.h"
#import "UserInfoVC.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>

Strong NSArray *dataArr;
Strong NSArray *imgArr;
Strong NSString *userPortraitUri;
Strong NSString *userName;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configData];
    [self configTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBarShadow:[UIImage new]];
    [self configNavigationBarHidden];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self configNavigationBarShow];
}

- (void)configData {
    self.userName = [DEFAULTS objectForKey:@"userName"];
    self.userPortraitUri = [DEFAULTS objectForKey:@"userPortraitUri"];
    
    if (!self.userName) {
        self.userName = @"未登录";
    }
    self.dataArr = @[@"我的钱包",@"收藏",@"相册",@"分布社交",@"设置"];
    self.imgArr = @[@"mine_icon_qb",@"mine_icon_collect",@"mine_icon_photo",@"mine_icon_fbsj",@"mine_icon_set"];
    
}

- (void)configTableView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.tableHeaderView = [self tableHeadView];
    tableView.backgroundColor = MACALKHexColor(@"#ECEDEE");
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:tableView];
    
}

- (UIView *)tableHeadView {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headImg = [[UIImageView alloc]init];
    headImg.backgroundColor = [UIColor redColor];
    headImg.layer.cornerRadius = 8;
    headImg.clipsToBounds = YES;
    [headImg sd_setImageWithURL:MACALKUrl(self.userPortraitUri)];
    [headView addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).with.offset(40);
        make.left.equalTo(headView).with.offset(25);
        make.size.mas_offset(CGSizeMake(65, 65));
    }];
    
    CommonLabel *username = [[CommonLabel alloc]initWithText:self.userName font:17 textColor:nil];
    [headView addSubview:username];
    [username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImg).with.offset(5);
        make.left.equalTo(headImg.mas_right).with.offset(20);
    }];
    
    CommonLabel *account = [[CommonLabel alloc]initWithText:[NSString stringWithFormat:@"撩信账号：****"] font:17 textColor:@"#6D6E6F"];
    [headView addSubview:account];
    [account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headImg).with.offset(-5);
        make.left.equalTo(headImg.mas_right).with.offset(20);
    }];
    
    UIImageView *nextImg = [[UIImageView alloc]initWithImage:MACALKImage(@"icon_next")];
    [headView addSubview:nextImg];
    [nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(account);
        make.right.equalTo(headView).with.offset(-15);
    }];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithImage:MACALKImage(@"mine_icon_erweima")];
    [headView addSubview:codeImg];
    [codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(account);
        make.right.equalTo(nextImg.mas_left).with.offset(-20);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userInfoTap)];
    [headView addGestureRecognizer:tap];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = MACALKHexColor(@"#ECEDEE");
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 3;
    }else if (section == 2) {
        return 1;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgArr[indexPath.row]]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    }else if(indexPath.section == 1){
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgArr[indexPath.row+1]]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row+1]];
    }else {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgArr[indexPath.row+4]]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row+4]];
    }
    
    UIImageView *nextImg = [[UIImageView alloc]initWithImage:MACALKImage(@"icon_next")];
    [cell.contentView addSubview:nextImg];
    [nextImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView).with.offset(-15);
    }];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)userInfoTap {
    UserInfoVC *infoVC = [[UserInfoVC alloc]init];
    infoVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:infoVC animated:YES];
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
