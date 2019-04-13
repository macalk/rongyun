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

Strong NSMutableArray *dataArr;
Strong NSString *userPortraitUri;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的";
    [self configData];
    [self configTableView];
}

- (void)configData {
    NSString *userName = [DEFAULTS objectForKey:@"userName"];
    NSString *userPortraitUri = [DEFAULTS objectForKey:@"userPortraitUri"];
    self.userPortraitUri = userPortraitUri;
    
    if (!userName) {
        userName = @"未登录";
    }
    self.dataArr = [[NSMutableArray alloc]initWithObjects:userName,@"支付",@"收藏",@"设置", nil];
    
}

- (void)configTableView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }
    
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row == 0) {
        
        UIImageView *headImg = [[UIImageView alloc]init];
        headImg.backgroundColor = [UIColor redColor];
        [headImg sd_setImageWithURL:MACALKUrl(self.userPortraitUri)];
        [cell.contentView addSubview:headImg];
        [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.left.equalTo(cell.contentView).with.offset(15);
            make.size.mas_offset(CGSizeMake(50, 50));
        }];
        
        UILabel *username = [[UILabel alloc]init];
        username.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
        [cell.contentView addSubview:username];
        [username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headImg);
            make.left.equalTo(headImg.mas_right).with.offset(20);
        }];
       
    }else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UserInfoVC *infoVC = [[UserInfoVC alloc]init];
        infoVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:infoVC animated:YES];
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
