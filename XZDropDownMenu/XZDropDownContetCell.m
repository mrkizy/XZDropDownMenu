//
//  XZDropDownContetCell.m
//  JKHire
//
//  Created by 徐智 on 2017/6/1.
//  Copyright © 2017年 xianshijian. All rights reserved.
//

#import "XZDropDownContetCell.h"
#import "WDConst.h"

@interface XZDropDownContetCell ()

@property (nonatomic, strong) UILabel *labContent;

@end

@implementation XZDropDownContetCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.labContent = [[UILabel alloc] init];
    self.labContent.textColor = XZCOLOR_RGBA(34, 58, 80, 1);
    self.labContent.font = [UIFont systemFontOfSize:14.0f];
    self.labContent.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.labContent];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setModel:(XZDropDownModel *)model{
    _model = model;
    self.labContent.text = model.content;
    self.labContent.textColor = model.selected ? XZCOLOR_RGBA(0, 199, 225, 1): XZCOLOR_RGBA(34, 58, 80, 1);
}

@end
