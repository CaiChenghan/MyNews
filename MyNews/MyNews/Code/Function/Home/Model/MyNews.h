//
//  MyNews.h
//  MyNews
//
//  Created by 蔡成汉 on 2017/4/7.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNews : NSObject

@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSArray *images;
@property (nonatomic , strong) NSString *source;
@property (nonatomic , strong) NSString *time;

/**
 重写init方法

 @param dic dic
 @return myNews
 */
-(instancetype)initWithDic:(NSDictionary *)dic;

@end
