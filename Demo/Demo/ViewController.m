//
//  ViewController.m
//  Demo
//
//  Created by 徐智 on 2017/6/11.
//  Copyright © 2017年 kizy. All rights reserved.
//

#import "ViewController.h"
#import "XZDropDownMenu.h"
#import "WDConst.h"

@interface ViewController () <XZDropDownMenuDelegate, XZDropDownMenuDataSource>

@property (nonatomic, strong) NSMutableArray *menuArr;
@property (nonatomic, copy) NSArray *allArr;
@property (nonatomic, strong) NSMutableArray *jobTypeArr;
@property (nonatomic, strong) NSMutableArray *positionArr;
@property (nonatomic, strong) NSMutableArray *sexArr;
@property (nonatomic, strong) NSMutableArray *ageArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupViews];
}

- (void)loadData{
    [self getMenuArr];
    [self getJobTypeArr];
    [self getPositionArr];
    [self getSexArr];
    [self getAgeArr];
    self.allArr = @[self.jobTypeArr, self.positionArr, self.sexArr, self.ageArr];
}

- (void)setupViews{
    XZDropDownMenu *menu = [[XZDropDownMenu alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
}

- (void)getMenuArr{
    self.menuArr = @[@"岗位类型", @"全福州", @"性别", @"年龄"];
}

- (void)getJobTypeArr{
    self.jobTypeArr = [NSMutableArray array];
    NSArray *array = @[@"不限", @"校内", @"家教", @"礼仪", @"会展", @"文员", @"销售", @"翻译", @"美工", @"模特", @"观众充场", @"送餐员", @"快递", @"推广", @"安保", @"演出", @"问卷调查", @"校园代理"];
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XZDropDownModel *model = [[XZDropDownModel alloc] init];
        model.content = obj;
        model.subContet = obj;
        if (idx == 0) {
            model.subContet = @"岗位类型";
        }
        [self.jobTypeArr addObject:model];
    }];
}

- (void)getPositionArr{
    self.positionArr = [NSMutableArray array];
    NSArray *array = @[@"全福州", @"闽侯县", @"鼓楼区", @"台江区", @"晋安区"];
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XZDropDownModel *model = [[XZDropDownModel alloc] init];
        model.content = obj;
        model.subContet = obj;
        [self.positionArr addObject:model];
    }];
}

- (void)getSexArr{
    self.sexArr = [NSMutableArray array];
    NSArray *array = @[@"不限", @"男", @"女"];
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XZDropDownModel *model = [[XZDropDownModel alloc] init];
        model.content = obj;
        model.subContet = obj;
        if (idx == 0) {
            model.subContet = @"性别";
        }
        [self.sexArr addObject:model];
    }];
}

- (void)getAgeArr{
    self.ageArr = [NSMutableArray array];
    NSArray *array = @[@"不限", @"18周岁以下", @"18！25周岁", @"25周岁以上"];
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XZDropDownModel *model = [[XZDropDownModel alloc] init];
        model.content = obj;
        model.subContet = obj;
        if (idx == 0) {
            model.subContet = @"年龄";
        }
        [self.ageArr addObject:model];
    }];
}

#pragma mark - XZDropDownMenuDataSource

- (NSInteger)numberOfColumsInXzDropMenu:(XZDropDownMenu *)menu{
    return self.menuArr.count;
}

- (NSString *)menu:(XZDropDownMenu *)menu titleForColumn:(NSInteger)column{
    NSString *title = self.menuArr[column];
    return title;
}

- (NSInteger)numberOfItemsOrRowsInXzDropMenu:(XZDropDownMenu *)menu atColumn:(NSInteger)column{
    NSArray *array = [self.allArr objectAtIndex:column];
    return array.count;
}

- (__kindof XZDropDownModel *)menu:(XZDropDownMenu *)menu modelForItemOrRowAtXZIndexPath:(XZIndexPath *)xzIndexPath{
    NSArray *array = [self.allArr objectAtIndex:xzIndexPath.column];
    XZDropDownModel *model = [array objectAtIndex:xzIndexPath.indexPath.row];
    return model;
}

- (BOOL)menu:(XZDropDownMenu *)menu shouldSupportCollectionViewAtColumn:(NSInteger)column{
    switch (column) {
        case 0:
        case 1:{
            return YES;
        }
            break;
            
        default:
            break;
    }
    return NO;
}

#pragma mark - XZDropDownMenuDelegate

- (void)menu:(XZDropDownMenu *)menu didSelectItemOrRowAtXZIndexPath:(XZIndexPath *)xzIndexPath{
    NSLog(@"我被点击了");
}

- (CGFloat)menu:(XZDropDownMenu *)menu heightForRowAtXzIndexPath:(XZIndexPath *)xzIndexPath{
    return 50.0f;
}

- (CGSize)menu:(XZDropDownMenu *)menu sizeForItemAtXzIndexPath:(XZIndexPath *)xzIndexPath{
    return CGSizeMake((SCREEN_WIDTH - 3) / 3, 50.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
