//
//  AppDelegate.m
//  Zhima
//
//  Created by 古振坤 on 2017/1/11.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsViewController.h"
#import "PersonViewController.h"
#import "PushStremViewController.h"

@interface AppDelegate ()<EMCallManagerDelegate>

@end

@implementation AppDelegate

+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (UIViewController *)createVCwithClass:(Class )class
                                  title:(NSString *)title
                                 normal:(NSString *)normal
                                 select:(NSString *)select
{
    UIViewController *vc = [[class alloc]init];
    UIImage *normalImage = [UIImage imageNamed:normal];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectImage = [UIImage imageNamed:select];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:normalImage selectedImage:selectImage];
    
    return vc;
}

- (UITabBarController *)createTabbarController
{
    NewsViewController *VC = (NewsViewController *)[self createVCwithClass:[NewsViewController class] title:@"学习报告" normal:@"tab_message_normal.png" select:@"tab_message_selected.png"];
    UINavigationController *NC = [[UINavigationController alloc]initWithRootViewController:VC];
    
    PersonViewController *OVC = (PersonViewController *)[self createVCwithClass:[PersonViewController class] title:@"我的" normal:@"tab_content_normal.png" select:@"tab_content_selected.png"];
    UINavigationController *ONC = [[UINavigationController alloc]initWithRootViewController:OVC];
    
    PushStremViewController *TVC = (PushStremViewController *)[self createVCwithClass:[PushStremViewController class] title:@"课程表" normal:@"tab_Action_normal.png" select:@"tab_Action_selected.png"];
    UINavigationController *TNC = [[UINavigationController alloc]initWithRootViewController:TVC];
    
    UITabBarController *tabbarVC = [[UITabBarController alloc]init];
    tabbarVC.viewControllers = @[NC,ONC,TNC];
    return tabbarVC;
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
//    self.mainNavigationController = [self createTabbarController];
    
    NSString *appKey = @"1129170203178077#zhima";
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didFinishLaunchingWithOptions:launchOptions appkey:appKey apnsCertName:nil otherConfig:@{kSDKConfigEnableConsoleLogger : [NSNumber numberWithBool:YES]}];
    
    EMOptions *options = [EMOptions optionsWithAppkey:appKey];
    //    options.apnsCertName = @"";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark  -- 环信delegate
    /*
     *  自动登录返回结果
     *
     *  @param aError 错误信息
     */
- (void)didAutoLoginWithError:(EMError *)aError{
        NSLog(@"error   %@",aError);
}

@end
