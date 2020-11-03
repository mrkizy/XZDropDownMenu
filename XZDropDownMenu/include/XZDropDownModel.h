//
//  XZDropDownModel.h
//  JKHire
//
//  Created by 徐智 on 2017/6/1.
//  Copyright © 2017年 xianshijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZDropDownModel : NSObject

/** 额外扩展模型 */
@property (nonatomic, strong) id extra;

/** 下拉菜单显示数据 */
@property (nonatomic, copy) NSString *content;

/** 菜单栏显示数据 */
@property (nonatomic, copy) NSString *subContet;

/** 选中状态 */
@property (nonatomic, assign) BOOL selected;

@end
