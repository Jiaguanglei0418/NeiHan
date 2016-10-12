//
//  NHCustomNoNetworkEmptyView.h
//  NeiHan
//
//  Created by Guangleijia on 16/10/12.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//
/**
 *  没有网络状态, 显示 View
 */
#import <UIKit/UIKit.h>

@interface NHCustomNoNetworkEmptyView : UIView

/** 没有网络，重试*/
@property (nonatomic, copy) void(^customNoNetworkEmptyViewDidClickRetryHandle)(NHCustomNoNetworkEmptyView *view);


+ (instancetype)customNoNetworkEmptyView;
@end
