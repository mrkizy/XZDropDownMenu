//
//  XDropDowmMenuCell.m
//  JKHire
//
//  Created by 徐智 on 2017/6/1.
//  Copyright © 2017年 xianshijian. All rights reserved.
//

#import "XDropDowmMenuCell.h"
#import "WDConst.h"

@interface XDropDowmMenuCell ()

@property (nonatomic, strong) UILabel *labContent;

@end

@implementation XDropDowmMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.labContent = [[UILabel alloc] init];
    self.labContent.textColor = XZCOLOR_RGBA(34, 58, 80, 1);
    self.labContent.font = [UIFont systemFontOfSize:14.0f];
    self.labContent.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = XZCOLOR_RGB(233, 233, 233);
    
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:view];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@0.7);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(XZDropDownModel *)model{
    _model = model;
    self.labContent.text = model.content;
    self.labContent.textColor = model.selected ? XZCOLOR_RGBA(0, 199, 225, 1): XZCOLOR_RGBA(34, 58, 80, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
