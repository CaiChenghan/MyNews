//
//  HotNewsCell.h
//  MyNews
//
//  Created by 蔡成汉 on 2017/4/7.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotNewsCell : UITableViewCell

@property (nonatomic , strong) NSString *title;

/**
 cell文字行数
 */
@property (nonatomic , assign) NSInteger numberOfLine;

@end
