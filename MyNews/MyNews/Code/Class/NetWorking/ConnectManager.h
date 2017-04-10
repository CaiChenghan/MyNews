//
//  ConnectManager.h
//  DemoOfAF
//
//  Created by 蔡成汉 on 16/3/17.
//  Copyright © 2016年 上海泰侠网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectManager : NSObject

/**
 *  单例
 *
 *  @return 实例化后的ConnectManager
 */
+(ConnectManager *)shareManager;

/**
 *  get请求
 *
 *  @param URLString URL
 *  @param param     参数
 *  @param success   请求成功
 *  @param failure   请求失败
 */
-(NSURLSessionDataTask *)getWithURLString:(NSString *)URLString
                  param:(NSDictionary *)param
                success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  post请求（普通post请求）
 *
 *  @param URLString URL
 *  @param param     参数
 *  @param success   请求成功
 *  @param failure   请求失败
 */
-(NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
                   param:(NSDictionary *)param
                 success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  post请求（带文件请求）
 *
 *  @param URLString URL
 *  @param param     参数
 *  @param block     文件data
 *  @param success   请求成功
 *  @param failure   请求失败
 */
-(NSURLSessionDataTask *)postWithURLString:(NSString *)URLString
                   param:(NSDictionary *)param
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
