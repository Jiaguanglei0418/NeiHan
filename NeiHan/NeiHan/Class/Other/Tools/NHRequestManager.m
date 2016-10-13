//
//  NHRequestManager.m
//  NeiHan
//
//  Created by Guangleijia on 16/10/13.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import "NHRequestManager.h"

@interface AFHTTPSessionManager (Shared)
// 设置为单例模式
+ (instancetype)sharedManager;
@end

@implementation AFHTTPSessionManager (Shared)
+ (instancetype)sharedManager
{
    static AFHTTPSessionManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [AFHTTPSessionManager manager];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return _instance;
}
@end

@implementation NHRequestManager

// GET
+ (void)GET:(NSString *)urlString
 parameters:(id)parameters
responseSerializerType:(NHResponseSeializerType)type
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager sharedManager];
    
    // 请求头
//    mgr.requestSerializer setValue:[self cooki] forHTTPHeaderField:<#(nonnull NSString *)#>
    
}
@end
