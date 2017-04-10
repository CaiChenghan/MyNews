//
//  ConnectManager.m
//  DemoOfAF
//
//  Created by 蔡成汉 on 16/3/17.
//  Copyright © 2016年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "ConnectManager.h"

static ConnectManager *connectManager = nil;

@interface ConnectManager ()

/**
 *  sessionManager
 */
@property (nonatomic , strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ConnectManager

/**
 *  单例
 *
 *  @return 实例化后的ConnectManager
 */
+(ConnectManager *)shareManager
{
    @synchronized (self)
    {
        if (connectManager == nil)
        {
            connectManager = [[self alloc] init];
        }
    }
    return connectManager;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 20;
//        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}

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
                failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [_sessionManager GET:URLString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,[self resetError:error]);
    }];
    return dataTask;
}


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
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [_sessionManager POST:URLString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,[self resetError:error]);
    }];
    return dataTask;
}

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
                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [_sessionManager POST:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,[self resetError:error]);
    }];
    return dataTask;
}

-(NSError *)resetError:(NSError *)error{
    NSError *tpError;
    if (error.code == NSURLErrorNotConnectedToInternet)
    {
        tpError = [NSError errorWithDomain:@"网络不可用" code:error.code userInfo:error.userInfo];
    }
    else if (error.code == NSURLErrorCannotFindHost)
    {
        tpError = [NSError errorWithDomain:@"主机不可用" code:error.code userInfo:error.userInfo];
    }
    else if (error.code == NSURLErrorCannotConnectToHost)
    {
        tpError = [NSError errorWithDomain:@"主机不可用" code:error.code userInfo:error.userInfo];
    }
    else if (error.code == NSURLErrorTimedOut)
    {
        tpError = [NSError errorWithDomain:@"请求超时" code:error.code userInfo:error.userInfo];
    }
    else if (error.code == NSURLErrorBadServerResponse)
    {
        tpError = [NSError errorWithDomain:@"服务器不可用" code:error.code userInfo:error.userInfo];
    }
    else if (error.code == NSURLErrorCancelled)
    {
        tpError = [NSError errorWithDomain:@"请求已取消" code:error.code userInfo:error.userInfo];
    }
    else
    {
        tpError = [NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo];
    }
    return tpError;
}

@end
