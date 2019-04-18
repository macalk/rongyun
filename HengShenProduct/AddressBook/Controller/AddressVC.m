//
//  AddressVC.m
//  HengShenProduct
//
//  Created by 落定 on 2019/4/10.
//  Copyright © 2019 macalk. All rights reserved.
//

#import "AddressVC.h"
#import "DSectionIndexItemView.h"
#import "DSectionIndexView.h"
#import "SearchResultVC.h"
#import "AddressHeadView.h"

@interface AddressVC ()<UITableViewDelegate,UITableViewDataSource,DSectionIndexViewDelegate,DSectionIndexViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>

Strong UITableView *tableView;
Strong DSectionIndexView *sectionIndexView;
Strong NSMutableDictionary *sectionDic;
Strong NSMutableArray *sections;

@end

@implementation AddressVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.sectionIndexView reloadItemViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"通讯录";
    [self configRightBarButtonWithImage:@"home_icon_more" Title:nil];
    [self configData];
    [self configView];
    
}

#define kSectionIndexWidth 20.f
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat kSectionIndexHeight = self.sections.count*25;
    
    self.sectionIndexView.frame = CGRectMake(CGRectGetWidth(self.tableView.frame) - kSectionIndexWidth, (CGRectGetHeight(self.tableView.frame) - kSectionIndexHeight)/2, kSectionIndexWidth, kSectionIndexHeight);
    [self.sectionIndexView setBackgroundViewFrame];
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)FirstCharactor:(NSString *)pString
{
    //转成了可变字符串
    NSMutableString *pStr = [NSMutableString stringWithString:pString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pPinYin = [pStr capitalizedString];
    //获取并返回首字母
    return [pPinYin substringToIndex:1];
}

- (void)configData {
    NSArray *testDataArr = @[@{@"name":@"速度"},@{@"name":@"阿布"},@{@"name":@"得我"},@{@"name":@"速度"},@{@"name":@"阿布"},@{@"name":@"得我"},@{@"name":@"速度"},@{@"name":@"阿布"},@{@"name":@"得我"},@{@"name":@"速度"},@{@"name":@"阿布"},@{@"name":@"得我"},@{@"name":@"速度"},@{@"name":@"阿布"},@{@"name":@"得我"},@{@"name":@"速度"},@{@"name":@"阿布"},@{@"name":@"得我"},@{@"name":@"速度"},@{@"name":@"阿布"},@{@"name":@"得我"}];
    
    self.sections = [NSMutableArray array];
    self.sectionDic = [NSMutableDictionary dictionary];
    
    NSMutableArray *hkBrokerListArr = [NSMutableArray arrayWithArray:testDataArr];
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
    [hkBrokerListArr sortUsingDescriptors:@[des]];
    
    for (int i = 0; i<testDataArr.count; i++) {
        
        NSString *name = hkBrokerListArr[i][@"name"];
        NSString *charStr = [self FirstCharactor:name];
        
        if (![self.sections containsObject:charStr]) {
            [self.sections addObject:charStr];
            
            NSMutableArray *itemArr = [NSMutableArray array];
            [itemArr addObject:name];
            [self.sectionDic setObject:itemArr forKey:charStr];
        }else {
            NSMutableArray *itemArr = [self.sectionDic objectForKey:charStr];
            [itemArr addObject:name];
            [self.sectionDic setObject:itemArr forKey:charStr];
        }
    }
}

- (void)configView {

    
    
    
    UISearchController *search = [[UISearchController alloc]initWithSearchResultsController:[SearchResultVC new]];
    //设置结果更新代理
    search.delegate = self;
    search.searchResultsUpdater = self;
    //搜索时，背景变暗色
    search.dimsBackgroundDuringPresentation = YES;
    [search.searchBar setBackgroundImage:[UIImage imageWithColor:MACALKHexColor(@"#ECEDEE")]];
    search.searchBar.frame = CGRectMake(0, 0, ScreenWidth, 60);
    [self.view addSubview:search.searchBar];
    
    
    AddressHeadView *headView = [[AddressHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,60, ScreenWidth, ScreenHeight-60) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = headView;
    [self.view addSubview:self.tableView];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self initIndexView];
}

- (void)initIndexView {
    self.sectionIndexView = [[DSectionIndexView alloc] init];
    self.sectionIndexView.backgroundColor = [UIColor clearColor];
    self.sectionIndexView.dataSource = self;
    self.sectionIndexView.delegate = self;
    self.sectionIndexView.isShowCallout = YES;
    self.sectionIndexView.calloutViewType = CalloutViewTypeForUserDefined;
    self.sectionIndexView.calloutDirection = SectionIndexCalloutDirectionLeft;
    self.sectionIndexView.calloutMargin = 20.f;
    [self.view addSubview:self.sectionIndexView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.sectionDic objectForKey:[self.sections objectAtIndex:section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"选择一个群";
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.imageView.image = [UIImage imageNamed:@"home_head_ex"];
    cell.textLabel.text = [[self.sectionDic objectForKey:[self.sections objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }else {
        
        
    }
    
}

#pragma mark DSectionIndexViewDataSource && delegate method
- (NSInteger)numberOfItemViewForSectionIndexView:(DSectionIndexView *)sectionIndexView
{
    return self.tableView.numberOfSections;
}

- (DSectionIndexItemView *)sectionIndexView:(DSectionIndexView *)sectionIndexView itemViewForSection:(NSInteger)section
{
    DSectionIndexItemView *itemView = [[DSectionIndexItemView alloc] init];
    
    itemView.titleLabel.text = [self.sections objectAtIndex:section];
    itemView.titleLabel.font = [UIFont systemFontOfSize:12];
    itemView.titleLabel.textColor = [UIColor darkGrayColor];
    itemView.titleLabel.highlightedTextColor = [UIColor redColor];
    itemView.titleLabel.shadowColor = [UIColor whiteColor];
    itemView.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    return itemView;
}

- (UIView *)sectionIndexView:(DSectionIndexView *)sectionIndexView calloutViewForSection:(NSInteger)section
{
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_zm_bg"]];
    img.frame = CGRectMake(0, 0, 80, 66);
    
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(13, 13, 40, 40);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:36];
    label.text = [self.sections objectAtIndex:section];
    label.textAlignment = NSTextAlignmentCenter;
    
    [img addSubview:label];
    return img;
}

- (NSString *)sectionIndexView:(DSectionIndexView *)sectionIndexView
               titleForSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
}

- (void)sectionIndexView:(DSectionIndexView *)sectionIndexView didSelectSection:(NSInteger)section
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
