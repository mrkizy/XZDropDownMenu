//
//  UIView+XZExtension.m
//  Demo
//
//  Created by 徐智 on 2017/6/11.
//  Copyright © 2017年 kizy. All rights reserved.
//

#import "UIView+XZExtension.h"

@implementation UIView (XZExtension)

#pragma mark - ***** Frame ******
- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}


- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y;{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)x{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}

- (void)setCenterY:(CGFloat)y{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}

#pragma mark - ***** 圆角 ******
- (void)setCornerValue:(CGFloat)value{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:value];
}

- (void)setCorner{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:2.0];
}

- (void)setToCircle{
    [self setCornerWithCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.width/2, 0)];
}

- (void)setCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.cornerRadius = size.width;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

#pragma mark - ***** 边框 ******
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor*)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)setBorderColor:(UIColor*)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.7;
    self.layer.borderColor = color.CGColor;
}

@end
