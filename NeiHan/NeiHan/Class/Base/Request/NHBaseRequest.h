//
//  NHBaseRequest.h
//  NeiHan
//
//  Created by Guangleijia on 16/10/13.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//
/**
 *  网络请求基类
 */
#import <Foundation/Foundation.h>

// 定义 block
typedef void(^NHAPIDidCompletion)(id response, BOOL success, NSString *message);

// 定义 代理
@protocol NHBaseRequestResponseDelegate <NSObject>
@required

/** 如果不用block 返回数据的话, 必须实现这个代理方法*/
- (void)requestSuccessResponse:(BOOL)success
                      response:(id)response
                       message:(NSString *)message;
@end

@interface NHBaseRequest : NSObject

/** 网络请求, 返回数据代理 */
kPROPERTY_DELEGATE(NHBaseRequestResponseDelegate, nh_delegate)
/** 链接 */
kPROPERTY_COPY(nh_url)
/** 默认 GET */
kPROPERTY_ASSIGN(BOOL, nh_isPost)
/** 图片数据 */
kPROPERTY_STRONG(NSArray<UIImage *>, nh_imgArray)


/** 构造方法 */
+ (instancetype)nh_request;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url
                           isPost:(BOOL)nh_isPost;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url
                           isPost:(BOOL)nh_isPost
                         delegate:(id <NHBaseRequestResponseDelegate>)nh_delegate;

/** 开始网络请求, 如果设置了代理, 不需要 block 回调 */
- (void)nh_sendRequest;
/** 开始请求, 没有设置代理, 或者设置了代理, 需要 block 回调, block 回调优先级高于代理 */
- (void)nh_sendRequestWithCompletion:(NHAPIDidCompletion)completion;

@end
