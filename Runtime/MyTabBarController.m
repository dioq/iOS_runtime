//
//  MyTabBarController.m
//  Runtime
//
//  Created by Dio Brand on 2022/8/7.
//  Copyright © 2022 Dio. All rights reserved.
//

#import "MyTabBarController.h"
#import "RuntimeViewController.h"
#import "MsgSendViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RuntimeViewController *mainVC = [[RuntimeViewController alloc] initWithNibName:@"RuntimeViewController" bundle:nil];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    //    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainNav.title = @"objc/runtime";
    [self addChildViewController:mainNav];
    
    MsgSendViewController *msgVC = [[MsgSendViewController alloc] initWithNibName:@"MsgSendViewController" bundle:nil];
    UINavigationController *msgNav = [[UINavigationController alloc] initWithRootViewController:msgVC];
    msgNav.title = @"objc/message";
    [self addChildViewController:msgNav];
    
    //    self.view.backgroundColor = [UIColor grayColor];
    //    self.tabBarItem. = [UIColor grayColor];
    [self lineColor];
    [self setTabbarBackGround];
    [self titleColor];
}

-(void)lineColor {
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
        standardAppearance.backgroundColor = [UIColor lightGrayColor];//根据自己的情况设置
        standardAppearance.shadowColor = [UIColor blackColor];//也可以设置为白色或任何颜色
        self.tabBar.standardAppearance = standardAppearance;
    }else{
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
        [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
        [UITabBar appearance].backgroundColor = [UIColor whiteColor];//根据自己的情况设置
    }
}

- (void)setTabbarBackGround{
    if(@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        //        appearance.backgroundImage = [self createImageWithColor:[UIColor clearColor]];
        //        appearance.shadowImage = [self createImageWithColor:[UIColor clearColor]];
        //下面这行代码最关键
        [appearance configureWithTransparentBackground];
        self.tabBar.standardAppearance = appearance;
    }else {
        //            [self.tabBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
        //
        //        [self.tabBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
        self.tabBar.translucent =YES;
    }
}

-(void)titleColor {
    if(@available(iOS 13.0, *)) {
        // iOS13 及以上
        self.tabBar.tintColor = [UIColor cyanColor];
        self.tabBar.unselectedItemTintColor = [UIColor grayColor];
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
    }else{
        // iOS13 以下
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor cyanColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];}
}

@end
