//
//  FoundVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "FoundVC.h"

@interface FoundVC ()<UITableViewDelegate,UITableViewDataSource>

Strong NSArray *dataArr;
Strong NSArray *imgArr;

@end

@implementation FoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"探索";
    self.dataArr = @[@"朋友圈",@"扫一扫",@"抖一下",@"热门电影",@"热搜音乐"];
    self.imgArr = @[@"",@"find_icon_sys",@"find_icon_yyy",@"find_icon_movie",@"find_icon_music"];
    [self configView];
}

- (void)configView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = MACALKHexColor(@"#ECEDEE");
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 3) {
        return 0;
    }
    return 2;
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
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgArr[indexPath.row+3]]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArr[indexPath.row+3]];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
