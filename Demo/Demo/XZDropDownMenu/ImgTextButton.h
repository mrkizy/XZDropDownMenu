//
//  ImgTextButton.h
//  JKHire
//
//  Created by fire on 16/10/11.
//  Copyright © 2016年 xianshijian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImgTextAlignMentType) {
    ImgTextAlignMentType_topToDown, //上下图文
    ImgTextAlignMentType_leftToRight,   //左右图文
    ImgTextAlignMentType_normal,    //正常
};

@interface ImgTextButton : UIButton

@property (nonatomic, assign) ImgTextAlignMentType alignmentType;
@property (nonatomic, strong) UIView *budgeView;

@end
