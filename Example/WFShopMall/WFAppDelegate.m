//
//  WFAppDelegate.m
//  WFShopMall
//
//  Created by wyxlh on 09/23/2019.
//  Copyright (c) 2019 wyxlh. All rights reserved.
//

#import "WFAppDelegate.h"
#import "YFMediatorManager+YFKitMain.h"
#import "WFShopMallViewController.h"
#import "WFViewController.h"
#import "WKHelp.h"
#import "WFLoginViewController.h"
@implementation WFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self createTabbar];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 创建tabbar
- (void)createTabbar{
    
    // Init `TABAnimated`, and set the properties you need.
    // 初始化TABAnimated，并设置TABAnimated相关属性
//    [[TABAnimated sharedAnimated] initWithOnlySkeleton];
//    // open log
//    // 开启日志
//    [TABAnimated sharedAnimated].openLog = YES;
//    // set gobal cornerRadius
//    [TABAnimated sharedAnimated].useGlobalCornerRadius = YES;
    
    //去掉导航栏的黑线
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //创建window
    UIWindow *window                         = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window                              = window;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    // 取出沙盒中存储的上次使用软件的版本号
//    NSUserDefaults *defaults                 = [NSUserDefaults standardUserDefaults];
//    NSString *lastVersion                    = [defaults stringForKey:key];
//    // 获得当前软件的版本号
//    NSString *currentVersion                 = [NSString getAppVersion];
        //如果没有登录
            UITabBarController *rootVC        = [YFMediatorManager rootTabBarCcontroller];            
            [YFMediatorManager addChildVC:[WFShopMallViewController new] normalImageName:@"delete" selectedImageName:@"delete" title:@"商城"];
            [YFMediatorManager addChildVC:[WFViewController new] normalImageName:@"delete" selectedImageName:@"delete" title:@"我的片区"];
            [YFMediatorManager addChildVC:[WFLoginViewController shareInstance] normalImageName:@"delete" selectedImageName:@"delete" title:@"denglu"];
            [YFMediatorManager setGlobalBackGroundColor:[UIColor whiteColor]];
            [YFMediatorManager setNarBarGlobalTextColor:[UIColor blackColor] andFontSize:18];
            
            [self.window setRootViewController:rootVC];
    
    [self.window makeKeyAndVisible];
    
}

@end
