//
//  UIView+XZExtension.h
//  Demo
//
//  Created by 徐智 on 2017/6/11.
//  Copyright © 2017年 kizy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XZExtension)

- (CGFloat)x;
- (CGFloat)y;

- (CGFloat)width;
- (CGFloat)height;

- (CGSize)size;
- (CGPoint)origin;

- (CGFloat)centerX;
- (CGFloat)centerY;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)setSize:(CGSize)size;

- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;

- (void)setCornerValue:(CGFloat)value;
- (void)setCorner;
- (void)setToCircle;
- (void)setCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)size;

- (void)setBorderWidth:(CGFloat)width andColor:(UIColor*)color;
- (void)setBorderColor:(UIColor*)color;

@end
