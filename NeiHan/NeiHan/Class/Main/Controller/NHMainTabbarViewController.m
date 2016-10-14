//
//  NHMainTabbarViewController.m
//  NeiHan
//
//  Created by Guangleijia on 16/10/12.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import "NHMainTabbarViewController.h"

#import "NHBaseNavigationViewController.h" // navController
#import "NHHomeViewController.h"
#import "NHCheckViewController.h"
#import "NHMessageViewController.h"
#import "NHDiscoverViewController.h"

#import "NHServiceListRequest.h" // 网络请求

@interface NHMainTabbarViewController ()

@end

@implementation NHMainTabbarViewController

/**
 设置tabbar外观
 */
+ (void)initialize
{
    // 设置不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar  appearance].barTintColor = kCOLOR_BARTINT;
    
    // 设置导航控制器
    UITabBarItem *item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 0.5);
    
    // 普通状态
    NSMutableDictionary *normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = kFONT(13.0);
    normalAtts[NSForegroundColorAttributeName] = kCOLOR_RGB(0.62, 0.62, 0.62);
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = kFONT(13.0);
    selectAttrs[NSForegroundColorAttributeName] = kCOLOR_RGB(0.42, 0.42, 0.42);
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [self addChildViewControllerWithClassname:[NHHomeViewController description] imagename:@"home" title:@"首页"];
    [self addChildViewControllerWithClassname:[NHDiscoverViewController description] imagename:@"Found" title:@"发现"];
    [self addChildViewControllerWithClassname:[NHCheckViewController description]imagename:@"audit" title:@"审核"];
    [self addChildViewControllerWithClassname:[NHMessageViewController description] imagename:@"newstab" title:@"消息"];

    NHServiceListRequest *request = [NHServiceListRequest nh_request];
    request.nh_url = kNHHomeServiceListAPI;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            NHBaseNavigationViewController *homeNav = (NHBaseNavigationViewController *)self.viewControllers.firstObject;
            NHHomeViewController *home = (NHHomeViewController *)homeNav.viewControllers.firstObject;
            home.models = [NHServiceListModel modelArrayWithDictArray:response];
        }
    }];
}


/**
 添加自控制器

 @param classname 类名
 @param imgname   图标名称
 @param title     标题
 */
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imgname
                                      title:(NSString *)title
{
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    NHBaseNavigationViewController *nav = [[NHBaseNavigationViewController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imgname];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imgname stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
