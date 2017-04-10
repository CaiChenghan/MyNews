//
//  HotNewsCell.m
//  MyNews
//
//  Created by 蔡成汉 on 2017/4/7.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "HotNewsCell.h"

@interface HotNewsCell ()

@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation HotNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialHotNewsCell];
    }
    return self;
}

-(void)initialHotNewsCell{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = _title;
}

-(void)setNumberOfLine:(NSInteger)numberOfLine{
    _numberOfLine = numberOfLine;
    _titleLabel.numberOfLines = _numberOfLine;
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
