//
//  WDConst.h
//  jianke
//
//  Created by admin on 15/9/2.
//  Copyright (c) 2015年 xianshijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+XZExtension.h"
#define XZCOLOR_RGB(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define XZCOLOR_RGBA(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]

#define SCREEN_WIDTH     [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen]bounds].size.height
#define SCREEN_SIZE      [UIScreen mainScreen].bounds.size
#define SCREEN_BOUNDS    [UIScreen mainScreen].bounds

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad


