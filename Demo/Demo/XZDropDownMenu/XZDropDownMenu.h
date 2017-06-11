//
//  XZDropDownMenu.h
//  JKHire
//
//  Created by yanqb on 2017/5/31.
//  Copyright © 2017年 xianshijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZDropDownModel.h"

@interface XZIndexPath : NSObject

//内容布局
@property (nonatomic, strong) NSIndexPath *indexPath;
//标题布局
@property (nonatomic, assign) NSInteger column;

- (instancetype)initWithColumn:(NSInteger)column indexPath:(NSIndexPath *)indexPath;

@end

@class XZDropDownMenu;
@protocol XZDropDownMenuDelegate <NSObject>

@optional

/** 选中 */
- (void)menu:(XZDropDownMenu *)menu didSelectItemOrRowAtXZIndexPath:(XZIndexPath *)xzIndexPath;

/** 设置下拉内容行高(只作用于TableView) */
- (CGFloat)menu:(XZDropDownMenu *)menu heightForRowAtXzIndexPath:(XZIndexPath *)xzIndexPath;

/** 设置下拉内容尺寸(只作用于CollectionView) */
- (CGSize)menu:(XZDropDownMenu *)menu sizeForItemAtXzIndexPath:(XZIndexPath *)xzIndexPath;

@end

@protocol XZDropDownMenuDataSource <NSObject>

@required
/** 配置菜单栏显示个数 */
- (NSInteger)numberOfColumsInXzDropMenu:(XZDropDownMenu *)menu;

/** 菜单栏标题 */
- (NSString *)menu:(XZDropDownMenu *)menu titleForColumn:(NSInteger)column;

/** 指定菜单栏对应的内容布局个数 */
- (NSInteger)numberOfItemsOrRowsInXzDropMenu:(XZDropDownMenu *)menu atColumn:(NSInteger)column;

/** 配置指定菜单栏对应关联对象 */
- (__kindof XZDropDownModel *)menu:(XZDropDownMenu *)menu modelForItemOrRowAtXZIndexPath:(XZIndexPath *)xzIndexPath;

@optional
/** 下拉菜单对应内容是否显示collectionView形式 */
- (BOOL)menu:(XZDropDownMenu *)menu shouldSupportCollectionViewAtColumn:(NSInteger)column;

@optional


@end

@interface XZDropDownMenu : UIView

@property (nonatomic, weak) id <XZDropDownMenuDelegate> delegate;
@property (nonatomic, weak)  id <XZDropDownMenuDataSource> dataSource;

/** 是否展开状态 */
@property (nonatomic, assign) BOOL isShow;

- (void)reloadItemsOrRowsAtXZIndexPaths:(NSArray <XZIndexPath *> *)xzIndexPaths;
- (void)reloadDataAtColumn:(NSInteger)column;
- (void)reloadData;
@end
