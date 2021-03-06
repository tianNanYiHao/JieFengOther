//
//  AppDelegate.m
//  SFoofSave
//
//  Created by Lff on 16/8/3.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "MyAppDelegate.h"
#import "SYViewController.h"
#import "MainNavigationController.h"
#import "IQKeyboardManager.h"
#import "NFCViewController.h"
#define STOREAPPID @"1163478399"

@interface MyAppDelegate ()

@end

@implementation MyAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self hsupdateAppFromAppStore];
    [IQKeyboardManager sharedManager];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SYViewController *v = [[SYViewController alloc] init];
    MainNavigationController *nva = [[MainNavigationController alloc] initWithRootViewController:v];
    _window.rootViewController = nva;
    [_window makeKeyWindow];

    return YES;
}

-(void)hsupdateAppFromAppStore{
  
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //5实现跳转到应用商店进行更新
    if(buttonIndex==1)
    {
        //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];
    }else{
        exit(0);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
