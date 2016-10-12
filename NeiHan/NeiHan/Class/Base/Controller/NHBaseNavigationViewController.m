//
//  NHBaseNavigationViewController.m
//  NeiHan
//
//  Created by Guangleijia on 16/10/12.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import "NHBaseNavigationViewController.h"

#import "UIBarButtonItem+Addition.h"

@interface NHBaseNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NHBaseNavigationViewController

+ (void)initialize
{
    // 设置不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    // 设置导航栏背景颜色
    [UINavigationBar appearance].barTintColor = kCOLOR_RGB(0.86f, 0.85f, 0.80f);
    
    // 设置导航栏标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = kCOLOR_RGB(0.42f, 0.33f, 0.27f);
    attrs[NSFontAttributeName] = kFONT(17.0f);
    [[UINavigationBar appearance] setTitleTextAttributes:attrs];
    
    // 设置导航控制器 item的外观
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    item.tintColor = kCOLOR_RGB(0.42f, 0.33f, 0.27f);
    // 设置字体大小
    {
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = kFONT(17.0);
        attrs[NSForegroundColorAttributeName] = kCOLOR_RGB(0.42f, 0.33f, 0.27f);
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    }
    
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取系统自带滑动手势的 target 对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势, 调用系统自带滑动手势 target 的 action 方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理, 拦截手势触发
    pan.delegate = self;
    // 给导航控制器的 View 添加全屏的滑动手势
    [self.view addGestureRecognizer:pan];
    
    // 禁止系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意: 只有非根控制器才有滑动返回功能, 根控制器没有
    // 判断导航控制器是否只有一个自控制器, 如果只有一个控制器, 就是根控制器
    if(self.viewControllers.count == 1){
        // 表示用户在根控制器界面, 就不需要触发滑动手势
        return NO;
    }
    return YES;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        /** 如果 栈中控制器数量大于1 加返回按钮 */
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 44, 44);
        [btn setImage:[UIImage imageNamed:@"back_neihan"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
        btn.tintColor = kCOLOR_RGB(0.42f, 0.33f, 0.27);
        [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem = leftItem;
    }else{
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"" tintColor:kCOLOR_RGB(0.42f, 0.33f, 0.27f) touchBlock:nil];
    }

    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
