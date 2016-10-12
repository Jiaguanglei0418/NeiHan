//
//  NHCustomLoadingAnimationView.m
//  NeiHan
//
//  Created by Guangleijia on 16/10/12.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import "NHCustomLoadingAnimationView.h"

@interface NHCustomLoadingAnimationView ()

kPROPERTY_WEAK(UIImageView, imgView)
kPROPERTY_STRONG(NSMutableArray, imageArray)

@end

@implementation NHCustomLoadingAnimationView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];;
    }
    return self;
}

- (void)showInView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    self.frame = view.bounds;
    self.imgView.frame = CGRectMake(0, 0, 70, 100);
    self.imgView.center = self.center;
    
    [self.imgView startAnimating];
}

- (void)dismiss {
    [_imageArray removeAllObjects];
    [_imgView stopAnimating];
    [_imgView removeFromSuperview];
    [self removeFromSuperview];
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _imgView = img;
        
        for (NSInteger i = 0; i < 17; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshjoke_loading_%ld", i % 17]];
            [self.imageArray addObject:image];
        }
        self.imgView.animationDuration = 1.0;
        self.imgView.animationRepeatCount = 0;
        self.imgView.animationImages = self.imageArray;
    }
    return _imgView;
}
@end
