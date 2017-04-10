//
//  MyNews.m
//  MyNews
//
//  Created by 蔡成汉 on 2017/4/7.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "MyNews.h"

@implementation MyNews

/**
 重写init方法
 
 @param dic dic
 @return myNews
 */
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self initiaMyNews:dic];
    }
    return self;
}

-(void)initiaMyNews:(NSDictionary *)dic{
    self.title = [dic getStringValueForKey:@"Title"];
    self.images = [dic getArrayValueForKey:@"ImagesList"];
    self.source = [dic getStringValueForKey:@"Source"];
    self.time = [dic getStringValueForKey:@"PublishTime"];
}

@end
