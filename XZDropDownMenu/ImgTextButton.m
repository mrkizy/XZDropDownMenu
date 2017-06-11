//
//  ImgTextButton.m
//  JKHire
//
//  Created by fire on 16/10/11.
//  Copyright © 2016年 xianshijian. All rights reserved.
//

#import "ImgTextButton.h"
#import "WDConst.h"

@implementation ImgTextButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)budgeView{
    if (!_budgeView) {
        _budgeView = [[UIView alloc] init];
        [_budgeView.layer setCornerRadius:5.0f];
        [_budgeView.layer setMasksToBounds:YES];
        _budgeView.backgroundColor = XZCOLOR_RGB(255, 97, 142);
        _budgeView.hidden = YES;
        [self addSubview:_budgeView];
    }
    return _budgeView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    switch (self.alignmentType) {
        case ImgTextAlignMentType_topToDown:{
            self.titleLabel.width = self.width;
            self.imageView.width = 46.0f;
            self.imageView.height = 46.0f;
            CGFloat margin = (self.height - self.imageView.height - self.titleLabel.height) / 2;
            self.imageView.centerX = self.width / 2;
            self.imageView.y = margin - 5;
            self.titleLabel.centerX = self.width / 2;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 5;
            if (_budgeView) {
                _budgeView.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 2, self.imageView.y, 10, 10);
            }
        }
            break;
        case ImgTextAlignMentType_normal:{
            if (_budgeView) {
                _budgeView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 2, self.titleLabel.y, 10, 10);
            }
        }
            break;
        case ImgTextAlignMentType_leftToRight:{
            CGFloat margin = (self.width - self.imageView.width - self.titleLabel.width) / 2;
            self.titleLabel.x = margin;
            self.imageView.x = self.titleLabel.width + margin + 2;
            if (_budgeView) {
                _budgeView.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 2, self.imageView.y, 10, 10);
            }
        }
            break;
        default:
            break;
    }
}

@end
