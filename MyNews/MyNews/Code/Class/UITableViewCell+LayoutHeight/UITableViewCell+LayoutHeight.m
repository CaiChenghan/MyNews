//
//  UITableViewCell+LayoutHeight.m
//  MyPlayer
//
//  Created by 蔡成汉 on 2017/4/7.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "UITableViewCell+LayoutHeight.h"

@implementation UITableViewCell (LayoutHeight)

/**
 获取cell高度
 
 @return 返回cell高度
 */
-(CGFloat)getLayoutCellHeight{
    return [self getLayoutCellHeightWithFlex:0];
}

/**
 获取cell高度
 
 @param flex 偏移量
 @return 返回cell高度
 */
-(CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex{
    UIView *bottomView = [self getBottomView:self.contentView.subviews];
    return [self getLayoutCellHeightWithFlex:flex bottomView:bottomView];
}

/**
 获取cell高度
 
 @param flex 偏移量
 @param bottomView 最底部的视图
 @return 返回cell高度
 */
-(CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex bottomView:(UIView *)bottomView{
    return [self getLayoutCellHeightWithFlex:flex bottomView:bottomView defaultHeight:44.0];
}

/**
 获取cell高度
 
 @param flex 偏移量
 @param bottomView 最底部的视图
 @param defaultHeight 默认cell高度
 @return 返回cell高度
 */
-(CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex bottomView:(UIView *)bottomView defaultHeight:(CGFloat)defaultHeight{
    if (bottomView) {
        return (bottomView.frame.origin.y + bottomView.frame.size.height+flex);
    }else{
        return defaultHeight;
    }
}


/**
 获取最底部的一个视图

 @param views 子视图
 @return 最底部的视图
 */
-(UIView *)getBottomView:(NSArray *)views{
    [self layoutIfNeeded];
    if (views && views.count > 0) {
        CGFloat height = 0;
        UIView *bottomView = [views objectAtIndex:0];
        for (UIView *tpView in views) {
            CGFloat flex = tpView.frame.origin.y + tpView.frame.size.height;
            if (flex > height) {
                height = flex;
                bottomView = tpView;
            }
        }
        return bottomView;
    }else{
        return nil;
    }
}

@end
