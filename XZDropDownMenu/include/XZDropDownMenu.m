//
//  XZDropDownMenu.m
//  JKHire
//
//  Created by yanqb on 2017/5/31.
//  Copyright © 2017年 xianshijian. All rights reserved.
//

#import "XZDropDownMenu.h"
#import "XZDropDownContetCell.h"
#import "XDropDowmMenuCell.h"
#import "ImgTextButton.h"
#import "WDConst.h"
#import <objc/runtime.h>

#define xzMenuHeight 50.0f
#define xzDropMenuHeight 50.0f

@implementation XZIndexPath

- (instancetype)initWithColumn:(NSInteger)column indexPath:(NSIndexPath *)indexPath{
    self = [super init];
    if (self) {
        self.column = column;
        self.indexPath = indexPath;
    }
    return self;
}

@end

@interface XZDropDownMenu () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>{
    NSInteger _currentColumn;
    NSInteger _preColumn;
}
@property (nonatomic, weak) UIView *line;
@property (nonatomic, weak) UIView *containtView;
//@property (nonatomic, strong) UICollectionView *menuCollectView;
@property (nonatomic, strong) UIScrollView *menuScrollView;
@property (nonatomic, strong) NSMutableArray <ImgTextButton *> *btnArray;
@property (nonatomic, strong) NSMutableArray *menuModelArray;
@property (nonatomic, assign) CGFloat orignHeight;

@end

@implementation XZDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.orignHeight = frame.size.height;
        self.backgroundColor = XZCOLOR_RGBA(0, 0, 0, 0.4);
        UITapGestureRecognizer *tagGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnClick:)];
        tagGes.delegate = self;
        [self addGestureRecognizer:tagGes];
        [self addObserver:self forKeyPath:@"isShow" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)setDataSource:(id<XZDropDownMenuDataSource>)dataSource{
    _dataSource = dataSource;
//    self.menuCollectView.hidden = NO;
    self.menuScrollView.hidden = NO;
}

#pragma mark - uicollectionview datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 10086) {
        if ([_dataSource respondsToSelector:@selector(numberOfColumsInXzDropMenu:)]) {
            return [_dataSource numberOfColumsInXzDropMenu:self];
        }else{
            return 0;
        }
    }
    if ([_dataSource respondsToSelector:@selector(numberOfItemsOrRowsInXzDropMenu:atColumn:)]) {
        return [_dataSource numberOfItemsOrRowsInXzDropMenu:self atColumn:collectionView.tag];
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 10086) {
        return CGSizeMake((SCREEN_WIDTH / 4), xzMenuHeight);
    }
    
    XZIndexPath *xzIndexPath = [[XZIndexPath alloc] initWithColumn:collectionView.tag indexPath:indexPath];
    if ([_delegate respondsToSelector:@selector(menu:sizeForItemAtXzIndexPath:)]) {
        return [_delegate menu:self sizeForItemAtXzIndexPath:xzIndexPath];
    }
    return CGSizeMake((SCREEN_WIDTH - 3) / 3, 50.0f);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (collectionView.tag == 10086) {
//        NSAssert([_dataSource respondsToSelector:@selector(menu:titleForColumn:)], @"未重写代理协议menu:titleForColumn:");
//        NSString *title = [_dataSource menu:self titleForColumn:indexPath.row];
//        XZDropDownModel *model = [[XZDropDownModel alloc] init];
//        model.subContet = title;
//        
//        if (self.menuModelArray.count > indexPath.item) {
//            [self.menuModelArray insertObject:model atIndex:indexPath.item];
//        }else{
//            [self.menuModelArray addObject:model];
//        }
//        
//        XZDropMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZDropMenuCollectionViewCell" forIndexPath:indexPath];
//        cell.model = model;
//        return cell;
//    }
//    
    XZIndexPath *xzIndexPath = [[XZIndexPath alloc] initWithColumn:collectionView.tag indexPath:indexPath];
    XZDropDownContetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZDropDownContetCell" forIndexPath:indexPath];
    XZDropDownModel *model = [_dataSource menu:self modelForItemOrRowAtXZIndexPath:xzIndexPath];
    NSMutableArray *array = [self getAssociatedArrayWithTag:collectionView.tag];
    if ([array indexOfObject:model] == NSNotFound) {
        if (array.count > indexPath.item) {
            [array insertObject:model atIndex:indexPath.item];
        }else{
            [array addObject:model];
        }
    }
    cell.model = model;
    return cell;
}

#pragma mark - uicollectionview delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 10086) {
        _currentColumn = indexPath.item;
        [self showOrHides];
        return;
    }
    
    XZIndexPath *xzIndexPath = [[XZIndexPath alloc] initWithColumn:_currentColumn indexPath:indexPath];
    if ([_delegate respondsToSelector:@selector(menu:didSelectItemOrRowAtXZIndexPath:)]) {
            [_delegate menu:self didSelectItemOrRowAtXZIndexPath:xzIndexPath];
        }
    [self setModelSelectedWithTag:collectionView.tag withIndex:indexPath.item];
    [self hides:YES atIndex:_currentColumn];
    [self setBtnStatueIndex:xzIndexPath];
}

- (void)setModelSelectedWithTag:(NSInteger)tag withIndex:(NSInteger)index{
    NSMutableArray *array = [self getAssociatedArrayWithTag:tag];
    [array enumerateObjectsUsingBlock:^(XZDropDownModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
        if (idx == index) {
            obj.selected = YES;
        }
    }];
}

#pragma mark - uitableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_dataSource respondsToSelector:@selector(numberOfItemsOrRowsInXzDropMenu:atColumn:)]) {
        return [_dataSource numberOfItemsOrRowsInXzDropMenu:self atColumn:tableView.tag];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XDropDowmMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XDropDowmMenuCell" forIndexPath:indexPath];
    XZIndexPath *xzIndexPath = [[XZIndexPath alloc] initWithColumn:tableView.tag indexPath:indexPath];
    XZDropDownModel *model = [_dataSource menu:self modelForItemOrRowAtXZIndexPath:xzIndexPath];
    NSMutableArray *array = [self getAssociatedArrayWithTag:tableView.tag];
    if ([array indexOfObject:model] == NSNotFound) {
        if (array.count > indexPath.row) {
            [array insertObject:model atIndex:indexPath.row];
        }else{
            [array addObject:model];
        }
    }
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(menu:heightForRowAtXzIndexPath:)]) {
        XZIndexPath *xzIndexPath = [[XZIndexPath alloc] initWithColumn:tableView.tag indexPath:indexPath];
        return [_delegate menu:self heightForRowAtXzIndexPath:xzIndexPath];
    }
    return xzDropMenuHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XZIndexPath *xzIndexPath = [[XZIndexPath alloc] initWithColumn:_currentColumn indexPath:indexPath];
    if ([_delegate respondsToSelector:@selector(menu:didSelectItemOrRowAtXZIndexPath:)]) {
        [_delegate menu:self didSelectItemOrRowAtXZIndexPath:xzIndexPath];
    }
    [self setModelSelectedWithTag:tableView.tag withIndex:indexPath.row];
    [self hides:YES atIndex:_currentColumn];
}

#pragma mark - 业务方法
- (void)showOrHides{
    if (self.isShow) {
        if (_currentColumn != _preColumn) {
            [self hides:NO atIndex:_preColumn];
            [self show:_currentColumn];
        }else{
            [self hides:YES atIndex:_currentColumn];
        }
    }else{
        [self show:_currentColumn];
    }
    if ([self isShouldSupportCollectinViewWithIndex:_currentColumn]) {
        UICollectionView *collectView = [self getAssociatedObjectWithTag:_currentColumn];
        [self.containtView bringSubviewToFront:collectView];
        [collectView reloadData];
    }else{
        UITableView *tableView = [self getAssociatedObjectWithTag:_currentColumn];
        [self.containtView bringSubviewToFront:tableView];
        [tableView reloadData];
    }
    _preColumn = _currentColumn;
}

- (void)show:(NSInteger)index{
    self.isShow = YES;
    self.height = self.orignHeight;
    self.height = SCREEN_HEIGHT;
    [UIView animateWithDuration:0.2f animations:^{
        CGFloat height = 0;
        NSInteger count = [_dataSource numberOfItemsOrRowsInXzDropMenu:self atColumn:index];
        if ([self isShouldSupportCollectinViewWithIndex:index]) {
            count = (count + (3 - 1)) / 3;
        }
        height = count * xzMenuHeight;
        CGFloat maxHeight = 5 * xzMenuHeight;
        
        if (height >= maxHeight) {
            height = maxHeight;
        }
        self.containtView.height = height;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hides:(BOOL)isAnimation atIndex:(NSInteger)index{
    self.isShow = NO;
    self.height = self.orignHeight;
    if (isAnimation) {
        [UIView animateWithDuration:0.2f animations:^{
            self.containtView.height = 0;
        } completion:^(BOOL finished) {
        }];
    }else{
        self.height = self.orignHeight;
        self.containtView.height = 0;
    }
}

// reload
- (void)reloadItemsOrRowsAtXZIndexPaths:(NSArray<XZIndexPath *> *)xzIndexPaths{
    [xzIndexPaths enumerateObjectsUsingBlock:^(XZIndexPath * _Nonnull xzIndexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [self reloadData:xzIndexPath];
    }];
}

- (void)reloadDataAtColumn:(NSInteger)column{
    id obj = [self getAssociatedObjectWithTag:column];
    [obj performSelector:@selector(reloadData)];
}

- (void)reloadData{
    [self reloadDataAtColumn:_currentColumn];
}

- (void)reloadData:(XZIndexPath *)xzIndexPath{
    if ([self isShouldSupportCollectinViewWithIndex:xzIndexPath.column]) {
        UICollectionView *collectView = [self getAssociatedObjectWithTag:xzIndexPath.column];
        [collectView reloadItemsAtIndexPaths:@[xzIndexPath.indexPath]];
    }else{
        UITableView *tableView = [self getAssociatedObjectWithTag:xzIndexPath.column];
        [tableView reloadRowsAtIndexPaths:@[xzIndexPath.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)btnOnClick:(UIButton *)sender{
    _currentColumn = sender.tag;
    [self showOrHides];
}

- (void)setBtnStatueIndex:(XZIndexPath *)xzIndexPath{
    UIButton *btn = [self.btnArray objectAtIndex:xzIndexPath.column];
    XZDropDownModel *model = [_dataSource menu:self modelForItemOrRowAtXZIndexPath:xzIndexPath];
    [btn setTitle:model.subContet forState:UIControlStateNormal];
}

- (void)setBtnHightedStatus:(BOOL)seleced atIndex:(NSInteger)index{
    [self.btnArray enumerateObjectsUsingBlock:^(ImgTextButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
        if (index == idx) {
            obj.selected = seleced;
        }
    }];
}

- (void)tapOnClick:(UITapGestureRecognizer *)ges{
    [self hides:YES atIndex:_currentColumn];
}

#pragma mark - 关联对象
- (void)setAssociatedObjectWithTag:(NSInteger)tag withObject:(id)object{
    objc_setAssociatedObject(self, NSSelectorFromString([NSString stringWithFormat:@"obj%ld", tag]), object, OBJC_ASSOCIATION_RETAIN);
}

- (id)getAssociatedObjectWithTag:(NSInteger)tag{
    id obj = objc_getAssociatedObject(self, NSSelectorFromString([NSString stringWithFormat:@"obj%ld", tag]));
    if (!obj) {
        if ([self isShouldSupportCollectinViewWithIndex:tag]) {
            obj = [self getCollectViewWithTag:tag];
        }else{
            obj = [self getTableViewWithTag:tag];
        }
        [self setAssociatedObjectWithTag:tag withObject:obj];
    }
    return obj;
}

- (UICollectionView *)getCollectViewWithTag:(NSInteger)tag{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = XZCOLOR_RGB(233, 233, 233);
    collectionView.tag = tag;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[XZDropDownContetCell class] forCellWithReuseIdentifier:@"XZDropDownContetCell"];
    [self.containtView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containtView);
    }];
    return collectionView;
}

- (UITableView *)getTableViewWithTag:(NSInteger)tag{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = tag;
    [tableView registerClass:[XDropDowmMenuCell class] forCellReuseIdentifier:@"XDropDowmMenuCell"];
    [self.containtView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containtView);
    }];
    return tableView;
}

- (NSMutableArray *)getAssociatedArrayWithTag:(NSInteger)tag{
    NSMutableArray *array = objc_getAssociatedObject(self, NSSelectorFromString([NSString stringWithFormat:@"array%ld", tag]));
    if (!array) {
        array = [NSMutableArray array];
        [self setAssociatedArrayWithArray:array withTag:tag];
    }
    return array;
}

- (void)setAssociatedArrayWithArray:(NSMutableArray *)array withTag:(NSInteger)tag{
    objc_setAssociatedObject(self, NSSelectorFromString([NSString stringWithFormat:@"array%ld", tag]), array, OBJC_ASSOCIATION_RETAIN);
}

//判断是否UITableView or UICollectionView
- (BOOL)isShouldSupportCollectinViewWithIndex:(NSInteger)index{
    if ([_dataSource respondsToSelector:@selector(menu:shouldSupportCollectionViewAtColumn:)]) {
        return [_dataSource menu:self shouldSupportCollectionViewAtColumn:index];
    }else{
        return NO;
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"isShow"]) {
//        NSNumber *value = [change objectForKey:@"NSKeyValueChangeNewKey"];
        [self.menuModelArray enumerateObjectsUsingBlock:^(XZDropDownModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.selected = NO;
            if (idx == _currentColumn && self.isShow) {
                obj.selected = YES;
            }
        }];
//        [self.menuCollectView reloadData];
        [self setBtnHightedStatus:_isShow atIndex:_currentColumn];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - lazy

- (UIScrollView *)menuScrollView{
    if (!_menuScrollView) {
        _menuScrollView = [[UIScrollView alloc] init];
        _menuScrollView.frame = CGRectMake(0, 0, self.width, self.orignHeight);
        _menuScrollView.backgroundColor = [UIColor whiteColor];
        _menuScrollView.contentSize = CGSizeMake(self.width, self.orignHeight);
        _menuScrollView.showsVerticalScrollIndicator = NO;
        _menuScrollView.showsHorizontalScrollIndicator = NO;
        
        NSAssert([_dataSource respondsToSelector:@selector(menu:titleForColumn:)], @"未重写代理协议menu:titleForColumn:");
        self.btnArray = [NSMutableArray array];
        NSInteger count = [_dataSource numberOfColumsInXzDropMenu:self];
        NSString *title = nil;
        ImgTextButton *btn = nil;
        for (NSInteger index = 0; index < count; index++) {
            title = [_dataSource menu:self titleForColumn:index];
            btn = [ImgTextButton buttonWithType:UIButtonTypeCustom];
            btn.alignmentType = ImgTextAlignMentType_leftToRight;
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:XZCOLOR_RGBA(34, 58, 80, 1) forState:UIControlStateNormal];
            [btn setTitleColor:XZCOLOR_RGBA(0, 199, 225, 1) forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:@"jiantou_down_icon_16"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"jiantou_up_icon_16"] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake((SCREEN_WIDTH / 4) * index, 0, SCREEN_WIDTH / 4, self.height);
            btn.tag = index;
            [self.btnArray addObject:btn];
            [_menuScrollView addSubview:btn];
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = XZCOLOR_RGB(233, 233, 233);
            self.line = line;
            
            [self addSubview:_menuScrollView];
            [self addSubview:self.line];
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(_menuScrollView);
                make.height.equalTo(@1);
            }];
            
        }
    }
    return _menuScrollView;
}

//- (UICollectionView *)menuCollectView{
//    if (!_menuCollectView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing = 0;
//        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        collectionView.backgroundColor = [UIColor whiteColor];
//        collectionView.tag = 10086;
//        collectionView.dataSource = self;
//        collectionView.delegate = self;
//        [collectionView registerClass:[XZDropMenuCollectionViewCell class] forCellWithReuseIdentifier:@"XZDropMenuCollectionViewCell"];
//        _menuCollectView = collectionView;
//        
//        UIView *line = [[UIView alloc] init];
//        line.backgroundColor = [UIColor XSJColor_clipLineGray];
//        self.line = line;
//        
//        [self addSubview:collectionView];
//        [self addSubview:self.line];
//        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.equalTo(self);
//            make.height.equalTo(@(xzMenuHeight));
//        }];
//    }
//    return _menuCollectView;
//}

- (UIView *)containtView{
    if (!_containtView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.orignHeight, self.width, 0)];
        view.clipsToBounds = YES;
        _containtView = view;
        [self addSubview:view];
    }
    return _containtView;
}

- (CGFloat)orignHeight{
    if (!_orignHeight) {
        _orignHeight = 50.0f;
    }
    return _orignHeight;
}

- (NSMutableArray *)menuModelArray{
    if (!_menuModelArray) {
        _menuModelArray = [NSMutableArray array];
    }
    return _menuModelArray;
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"isShow"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
