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
    
    // 如果返回数据类型不是 json 格式
    if(type != NHResponseSeializerTypeJSON && type != NHResponseSeializerTypeDefault){
        mgr.responseSerializer = [self responseSerializerWithSerializerType:type];
    }
    
    // https证书设置
    /*
     AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
     policy.allowInvalidCertificates = YES;
     manager.securityPolicy  = policy;
     */
    [mgr GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // success
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


// POST
+ (void)POST:(NSString *)urlString parameters:(id)parameters responseSerializerType:(NHResponseSeializerType)type success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager sharedManager];
    // 如果返回数据类型不是 json 格式
    if(type != NHResponseSeializerTypeJSON && type != NHResponseSeializerTypeDefault){
        mgr.responseSerializer = [self responseSerializerWithSerializerType:type];
    }
    
    //  https证书设置
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    policy.allowInvalidCertificates = YES;
    mgr.securityPolicy  = policy;
    
    
    [mgr POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 失败
        if (failure) {
            failure(error);
        }
    }];
}

// POST - 上传
+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
responseSerializerType:(NHResponseSeializerType)type
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager sharedManager];
    // 如果返回数据类型不是 json 格式
    if(type != NHResponseSeializerTypeJSON && type != NHResponseSeializerTypeDefault){
        mgr.responseSerializer = [self responseSerializerWithSerializerType:type];
    }
    
    [mgr POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}



/**
 设置数据解析类型

 @param serilizerType 类型
 */
+ (AFHTTPResponseSerializer *)responseSerializerWithSerializerType:(NHResponseSeializerType)serilizerType
{
    switch (serilizerType) {
            
        case NHResponseSeializerTypeDefault: // default is JSON
            return [AFJSONResponseSerializer serializer];
            break;
            
        case NHResponseSeializerTypeJSON: // JSON
            return [AFJSONResponseSerializer serializer];
            break;
            
        case NHResponseSeializerTypeXML: // XML
            return [AFXMLParserResponseSerializer serializer];
            break;
            
        case NHResponseSeializerTypePlist: // Plist
            return [AFPropertyListResponseSerializer serializer];
            break;
            
        case NHResponseSeializerTypeCompound: // Compound
            return [AFCompoundResponseSerializer serializer];
            break;
            
        case NHResponseSeializerTypeImage: // Image
            return [AFImageResponseSerializer serializer];
            break;
            
        case NHResponseSeializerTypeData: // Data
            return [AFHTTPResponseSerializer serializer];
            break;
            
        default:  // 默认解析器为 JSON解析
            return [AFJSONResponseSerializer serializer];
            break;
    }
}
@end
