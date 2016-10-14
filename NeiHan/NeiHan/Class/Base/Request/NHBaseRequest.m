//
//  NHBaseRequest.m
//  NeiHan
//
//  Created by Guangleijia on 16/10/13.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import "NHBaseRequest.h"

#import "NHRequestManager.h"  // 网络请求管理类


@implementation NHBaseRequest


#pragma mark - 构造
+ (instancetype)nh_request
{
    return [[self alloc] init];
}

+ (instancetype)nh_requestWithUrl:(NSString *)nh_url
{
    return [self nh_requestWithUrl:nh_url isPost:NO];
}

+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost
{
    return [self nh_requestWithUrl:nh_url isPost:nh_isPost delegate:nil];
}

+ (instancetype)nh_requestWithUrl:(NSString *)nh_url
                           isPost:(BOOL)nh_isPost
                         delegate:(id<NHBaseRequestResponseDelegate>)nh_delegate
{
    NHBaseRequest *request = [self nh_request];
    request.nh_url = nh_url;
    request.nh_isPost = nh_isPost;
    request.nh_delegate = nh_delegate;
    
    return request;
}


#pragma mark - 发送请求
- (void)nh_sendRequest
{
    return [self nh_sendRequestWithCompletion:nil];
}

- (void)setNh_url:(NSString *)nh_url
{
    if (nh_url.length == 0 || [nh_url isKindOfClass:[NSNull class]]) {
        return;
    }
    _nh_url = nh_url;
}

- (void)nh_sendRequestWithCompletion:(NHAPIDidCompletion)completion
{
    // 链接
    NSString *url = self.nh_url;
    if (url.length == 0) return;
    
    // 参数
//    NSDictionary *params = [self ];
    
    // post
    if (self.nh_isPost) {
        if (self.nh_imgArray.count == 0) { // 普通 Post
            [NHRequestManager POST:[url noWhiteSpaceString] parameters:[self params] responseSerializerType:NHResponseSeializerTypeJSON success:^(id responseObject) {
                // 处理数据
                [self handleResponse:responseObject completion:completion];
            } failure:^(NSError *error) {
                // 数据请求失败, 暂时不做处理
                kLOG(@"error-request : %@", error.localizedDescription);
            }];
        }
    } else { // GET 请求
        [NHRequestManager GET:[url noWhiteSpaceString] parameters:[self params] responseSerializerType:NHResponseSeializerTypeJSON success:^(id responseObject) {
            // 处理数据
            [self handleResponse:responseObject completion:completion];

        } failure:^(NSError *error) {
            // 数据请求失败, 暂时不做处理
            kLOG(@"error-request : %@", error.localizedDescription);
        }];
    }
    
    // 上传图片
    if(self.nh_imgArray.count){
        [NHRequestManager POST:[url noWhiteSpaceString] parameters:[self params] responseSerializerType:NHResponseSeializerTypeJSON constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSInteger imgCount = 0;
            for (UIImage *img in self.nh_imgArray) {
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                formater.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
                NSString *filename = [[NSString alloc] initWithFormat:@"%@%@.png", [formater stringFromDate:[NSDate date]], @(imgCount)];
                [formData appendPartWithFileData:UIImagePNGRepresentation(img) name:@"file" fileName:filename mimeType:@"image/png"];
                imgCount++;
            }
        } success:^(id responseObject) {
            // 处理数据
            [self handleResponse:responseObject completion:completion];
        } failure:^(NSError *error) {
            // 数据请求失败, 暂时不做处理
            kLOG(@"error-request : %@", error.localizedDescription);
        }];
    }
}


- (void)handleResponse:(id)responseObject completion:(NHAPIDidCompletion)completion {
    // 接口约定，如果message为retry即重试
    NSString *code = [responseObject[@"head"] objectForKey:@"code"];
    if (![code isEqualToString:@"0000"]) {
        [self nh_sendRequestWithCompletion:completion];
        return  ;
    }
    
    // 数据请求成功回调
    BOOL success = [code isEqualToString:@"0000"];
    if (completion) {
        completion(responseObject[@"body"], success, @"");
    } else if (self.nh_delegate) {
        if ([self.nh_delegate respondsToSelector:@selector(requestSuccessResponse:response:message:)]) {
            [self.nh_delegate requestSuccessResponse:success response:responseObject[@"body"] message:@""];
        }
    }
    // 请求成功，发布通知
    [NSNotificationCenter postNotification:kNHRequestSuccessNotification];
}


- (NSDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"p"] = @"i";
    params[@"t"] = @"18614079396";
    
    [params addEntriesFromDictionary:self.mj_keyValues];
    
    if ([params.allKeys containsObject:@"nh_delegate"]) {
        [params removeObjectForKey:@"nh_delegate"];
    }
    if ([params.allKeys containsObject:@"nh_isPost"]) {
        [params removeObjectForKey:@"nh_isPost"];
    }
    if ([params.allKeys containsObject:@"nh_url"]) {
        [params removeObjectForKey:@"nh_url"];
    }
    if (self.nh_imgArray.count == 0) {
        if ([params.allKeys containsObject:@"nh_imageArray"]) {
            [params removeObjectForKey:@"nh_imageArray"];
        }
    }
    return params;
}

@end
