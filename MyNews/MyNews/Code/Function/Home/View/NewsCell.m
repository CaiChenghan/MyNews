//
//  NewsCell.m
//  MyNews
//
//  Created by 蔡成汉 on 2017/4/7.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell ()

/**
 标题
 */
@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation NewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialNewsCell];
    }
    return self;
}

-(void)initialNewsCell{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}

-(void)setMyNews:(MyNews *)myNews{
    _myNews = myNews;
    
    //数据分发
    _titleLabel.text = _myNews.title;
    
    //移除所有的图片
    for (UIView *tpView in self.contentView.subviews) {
        if ([tpView isKindOfClass:[UIImageView class]]) {
            [tpView removeFromSuperview];
        }
    }
    //创建新的图片:根据图片数量
    if (myNews.images.count > 0) {
        //创建图片
        if (myNews.images.count > 1) {
            //多张图
            UIView *lastView;
            for (int i=0; i<myNews.images.count; i++) {
                UIImageView *tpImageView = [[UIImageView alloc]init];
                tpImageView.backgroundColor = [UIColor clearColor];
                tpImageView.contentMode = UIViewContentModeScaleAspectFit;
                [self.contentView addSubview:tpImageView];
                NSDictionary *tpDic = [myNews.images objectAtIndex:i];
                [tpImageView sd_setImageWithURL:[NSURL URLWithString:[tpDic getStringValueForKey:@"ImgPath"]] placeholderImage:nil options:SDWebImageProgressiveDownload];
                if (i == 0) {
                    [tpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_titleLabel.mas_bottom).offset(8);
                        make.left.equalTo(self.contentView.mas_left).offset(10);
                        make.width.equalTo([NSNumber numberWithFloat:((self.contentView.width - 10.0*2 - 8.0*2)/3.0)]);
                        make.height.equalTo(tpImageView.mas_width).multipliedBy(0.75);
                    }];
                }else{
                    [tpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_titleLabel.mas_bottom).offset(8);
                        make.left.equalTo(lastView.mas_right).offset(8);
                        make.width.equalTo(lastView.mas_width);
                        make.height.equalTo(lastView.mas_height);
                    }];
                }
                lastView = tpImageView;
            }
            
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).offset(8);
                make.left.equalTo(self.contentView.mas_left).offset(10);
                make.right.equalTo(self.contentView.mas_right).offset(-10);
            }];
            
        }else{
            //单张图
            UIImageView *tpImageView = [[UIImageView alloc]init];
            tpImageView.backgroundColor = [UIColor clearColor];
            tpImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:tpImageView];
            NSDictionary *tpDic = [myNews.images lastObject];
            [tpImageView sd_setImageWithURL:[NSURL URLWithString:[tpDic getStringValueForKey:@"ImgPath"]] placeholderImage:nil options:SDWebImageProgressiveDownload];
            
            [tpImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).offset(8);
                make.left.equalTo(self.contentView.mas_left).offset(10);
                make.width.equalTo([NSNumber numberWithFloat:((self.contentView.width - 10.0*2 - 8.0*2)/3.0)]);
                make.height.equalTo(tpImageView.mas_width).multipliedBy(0.75);
            }];
            
            //标题重新约束
            [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).offset(8);
                make.left.equalTo(tpImageView.mas_right).offset(8);
                make.right.equalTo(self.contentView.mas_right).offset(-10);
            }];
        }
    }
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
