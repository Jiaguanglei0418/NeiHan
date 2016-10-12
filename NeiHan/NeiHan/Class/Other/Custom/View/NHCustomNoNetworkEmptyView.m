//
//  NHCustomNoNetworkEmptyView.m
//  NeiHan
//
//  Created by Guangleijia on 16/10/12.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import "NHCustomNoNetworkEmptyView.h"


@interface NHCustomNoNetworkEmptyView()

kPROPERTY_WEAK(UIImageView, topImgView)
kPROPERTY_WEAK(UIButton, retryBtn)

@end

@implementation NHCustomNoNetworkEmptyView
+ (instancetype)customNoNetworkEmptyView
{
    return [[self alloc] init];
}

- (UIImageView *)topImgView
{
    if (!_topImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        _topImgView = imgView;
        imgView.layer.masksToBounds = YES;
        imgView.backgroundColor = kCommonBgColor;
    }
    return _topImgView;
}

- (UIButton *)retryBtn {
    if (!_retryBtn) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _retryBtn = btn;
        
        btn.backgroundColor = kOrangeColor;
        [btn setTitle:@"马上重试" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = kFONT(15);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenDisabled = NO;
        btn.adjustsImageWhenHighlighted = NO;
    }
    return _retryBtn;
}

- (void)btnClick:(UIButton *)btn {
    if (self.customNoNetworkEmptyViewDidClickRetryHandle) {
        self.customNoNetworkEmptyViewDidClickRetryHandle(self);
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat topTipW = 100;
    CGFloat topTipX = kSCREEN_WIDTH / 2.0 - topTipW / 2.0;
    CGFloat topTipY = 150;
    CGFloat topTipH = 100;
    self.topImgView.frame = CGRectMake(topTipX, topTipY, topTipW, topTipH);
    
    CGFloat retryX = topTipX + 20;
    CGFloat retryY = self.topImgView.bottom + 15;
    CGFloat retryW = 60;
    CGFloat retryH = 25;
    self.retryBtn.frame = CGRectMake(retryX, retryY, retryW, retryH);
}
@end
