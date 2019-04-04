//
//  AppDelegate.m
//  Honey
//
//  Created by 李高锋 on 16/9/22.
//  Copyright © 2016年 GaoF. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GAWelcome.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *windows;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
        
    ViewController *viewC = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
