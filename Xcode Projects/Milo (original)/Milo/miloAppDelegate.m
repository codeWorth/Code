//
//  miloAppDelegate.m
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "miloAppDelegate.h"

@implementation miloAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIColor *barColor = [UIColor colorWithRed:146/256.0 green:196/256.0 blue:252/256.0 alpha:0.2];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [barColor setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *gradientImage44 = image; //replace "nil" with your method to programmatically create a UIImage object with transparent colors for portrait orientation
    
    //customize the appearance of UINavigationBar
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    // Override point for customization after application launch.
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

@end
