//
//  TCAppDelegate.m
//  TCTableViewSearchController
//
//  Created by CocoaPods on 12/08/2014.
//  Copyright (c) 2014 Tim G Carlson. All rights reserved.
//

#import "TCAppDelegate.h"
#import "TCDog.h"
#import "TCDemoTableViewController.h"

@implementation TCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *dogArray = @[[TCDog dogWithName:@"Chas" ownerName:@"Tim" birthYear:@(2005) breed:@"Brussels Griffon"],
                          [TCDog dogWithName:@"Perry" ownerName:@"Tim" birthYear:@(2005) breed:@"Brussels Griffon"],
                          [TCDog dogWithName:@"Carlos" ownerName:@"Inga" birthYear:@(2005) breed:@"Miniature Dachshund"],
                          [TCDog dogWithName:@"Pottsy" ownerName:@"Matt" birthYear:@(2008) breed:@"Miniature Dachshund"],
                          [TCDog dogWithName:@"Arya" ownerName:@"Lisa" birthYear:@(2011) breed:@"Terrier"],
                          [TCDog dogWithName:@"Louis" ownerName:@"Glenn" birthYear:@(2003) breed:@"Miniature Schnauzer"],
                          [TCDog dogWithName:@"Bruiser" ownerName:@"Kathy" birthYear:@(2007) breed:@"Terrier"],
                          [TCDog dogWithName:@"Walter" ownerName:@"Erica" birthYear:@(2012) breed:@"French Bulldog"],
                          [TCDog dogWithName:@"Benny" ownerName:@"Cheryl" birthYear:@(2011) breed:@"Australian Shepherd"],
                          [TCDog dogWithName:@"Brian" ownerName:@"Peter" birthYear:@(2005) breed:@"Beagle"],
                          ];
    
    UINavigationController *navigationController = (UINavigationController *)[self.window rootViewController];
    TCDemoTableViewController *viewController = (TCDemoTableViewController *)navigationController.viewControllers[0];
    viewController.dogArray = dogArray;
    
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
