//
//  NHBaseViewController.m
//  NeiHan
//
//  Created by Guangleijia on 16/10/12.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import "NHBaseViewController.h"
#import "NSNotificationCenter+Addition.h" // 发送通知
#import "NHCustomNoNetworkEmptyView.h"    // 没有网络, 空白显示 View
#import "NHCustomLoadingAnimationView.h"  // 加载动画
#import "SDImageCache.h"
#import "YYWebImageManager.h"
#import "YYDiskCache.h"
#import "YYMemoryCache.h"

@interface NHBaseViewController ()

@property (nonatomic, weak) NHCustomNoNetworkEmptyView *noNetworkEmptyView;
@property (nonatomic, weak) NHCustomLoadingAnimationView *animationView;

@end

@implementation NHBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 解决自定义 leftNavigationItem, 返回手势失效
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    // 当是侧滑手势的时候, 设置 scrollView 需要此手势失效才生效即可
    for(UIGestureRecognizer *gesture in gestureArray){
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            
            for (UIView  *subView in self.view.subviews) {
                if ([subView isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *scrollV = (UIScrollView *)subView;
                    [scrollV.panGestureRecognizer requireGestureRecognizerToFail:gesture];
                }
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView setAnimationsEnabled:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;

    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    
    [NSNotificationCenter addObserver:self action:@selector(requestSuccessNotification) name:kNHRequestSuccessNotification];
}

- (void)requestSuccessNotification {
    [self hideLoadingAnimation];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 页面跳转
- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)())completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (NHCustomNoNetworkEmptyView *)noNetworkEmptyView {
    if (!_noNetworkEmptyView) {
        NHCustomNoNetworkEmptyView *empty = [[NHCustomNoNetworkEmptyView alloc] init];
        [self.view addSubview:empty];
        _noNetworkEmptyView = empty;
        
        WS(weakSelf);
        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        empty.customNoNetworkEmptyViewDidClickRetryHandle = ^(NHCustomNoNetworkEmptyView *emptyView) {
            [weakSelf loadData];
        };
    }
    return _noNetworkEmptyView;
}

- (void)showLoadingAnimation {
    NHCustomLoadingAnimationView *animation = [[NHCustomLoadingAnimationView alloc] init];
    [animation showInView:self.view];
    _animationView = animation;
    [self.view bringSubviewToFront:animation];
}

- (void)hideLoadingAnimation {
    [_animationView dismiss];
    _animationView = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.animationView];
}

- (void)loadData {
    //    [self showLoadingAnimation];
    //
    //    // 网络不可用
    //    if ([AFNetworkReachabilityManager sharedManager].reachable == NO) {
    //
    //        [self hideLoadingAnimation];
    ////        self.noNetworkEmptyView.hidden = NO;
    //
    //    } else { // 网络可用
    //
    //
    //        [self.noNetworkEmptyView removeFromSuperview];
    //        _noNetworkEmptyView = nil;
    //
    //    }
}

- (BOOL)isNetworkReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[[YYWebImageManager sharedManager] cache].diskCache removeAllObjects];
    [[[YYWebImageManager sharedManager] cache].memoryCache removeAllObjects];
}


@end
