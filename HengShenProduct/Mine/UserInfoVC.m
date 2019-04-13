//
//  UserInfoVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/12.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "UserInfoVC.h"
#import "UpLoadUserHeadImgVC.h"

@interface UserInfoVC ()<UITableViewDelegate,UITableViewDataSource>

Strong NSMutableArray *dataArr;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"个人信息";
    self.dataArr = [NSMutableArray arrayWithObjects:@"头像",@"名字", nil];
    [self configView];
}

- (void)configView {
    
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row]];
    
    if (indexPath.row == 0) {
        
        UIImageView *headImg = [[UIImageView alloc]init];
        headImg.backgroundColor = [UIColor redColor];
        [headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[DEFAULTS objectForKey:@"userPortraitUri"]]]];
        [cell.contentView addSubview:headImg];
        [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).with.offset(-20);
            make.size.mas_offset(CGSizeMake(50, 50));
        }];
        
    }else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[DEFAULTS objectForKey:@"userName"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UpLoadUserHeadImgVC *vc = [[UpLoadUserHeadImgVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
