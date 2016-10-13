//
//  NHBaseRequest.m
//  NeiHan
//
//  Created by Guangleijia on 16/10/13.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import "NHBaseRequest.h"

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
            [NH];
        }
    }
}

@end
