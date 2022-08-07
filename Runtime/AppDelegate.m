//
//  AppDelegate.m
//  Runtime
//
//  Created by hello on 2019/9/30.
//  Copyright © 2019 Dio. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MyTabBarController *tabBarCtrl = [[MyTabBarController alloc] init];
    self.window.rootViewController = tabBarCtrl;

    return YES;
}

@end
