//
//  NHRequestManager.h
//  NeiHan
//
//  Created by Guangleijia on 16/10/13.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//
/**
 *  网络请求 管理工具类
 */
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 数据解析器类型
 */
typedef NS_ENUM(NSUInteger, NHResponseSeializerType) {
    /**
     *  默认类型 JSON  如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    NHResponseSeializerTypeDefault,
    /**
     *  JSON类型 如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    NHResponseSeializerTypeJSON,
    /*
     *  XML类型 如果使用这个响应解析器类型,那么请求返回的数据将会是XML格式
     */
    NHResponseSeializerTypeXML,
    /**
     *  Plist类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Plist格式
     */
    NHResponseSeializerTypePlist,
    /*
     *  Compound类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Compound格式
     */
    NHResponseSeializerTypeCompound,
    /**
     *  Image类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Image格式
     */
    NHResponseSeializerTypeImage,
    /**
     *  Data类型 如果使用这个响应解析器类型,那么请求返回的数据将会是二进制格式
     */
    NHResponseSeializerTypeData
};


@interface NHRequestManager : NSObject


/**
 GET
 
 @param urlString  URL
 @param parameters  参数
 @param type       返回数据类型(默认是 json)
 @param success    请求成功回调
 @param failure    请求失败回调
 */
+ (void)GET:(NSString *)urlString parameters:(id)parameters responseSerializerType:(NHResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 POST
 
 @param urlString  URL
 @param parameters  参数
 @param type       返回数据类型(默认是 json)
 @param success    请求成功回调
 @param failure    请求失败回调
 */
+ (void)POST:(NSString *)urlString parameters:(id)parameters responseSerializerType:(NHResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 POST: 上传数据 NSURLSession
 
 @param urlString  URL
 @param parameters  参数
 @param type       返回数据类型(默认是 json)
 @param block      上传数据
 @param success    请求成功回调
 @param failure    请求失败回调
 */
+ (void)POST:(NSString *)urlString
  parameters:(id)parameters
responseSerializerType:(NHResponseSeializerType)type
constructingBodyWithBlock:(void(^)(id <AFMultipartFormData> formData))block
     success:(void(^)(id responseObject))success
     failure:(void(^)(NSError *error))failure;


/**
 取消网络请求
 */
+ (void)cancelAllRequests;
@end
