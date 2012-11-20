//
//  CocktailBookAppDelegate.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CocktailBookAppDelegate.h"

#import "CocktailBookViewController.h"
#import "CBTabBarViewController.h"
#import "CBCocktailListNavigationController.h"
#import "CBCocktailListViewController.h"
#import "CBCategoriesViewController.h"

#define kCustomiseTabBar        0   // compile time option to turn a custom tab bar on or off
#define kDefaultTabSelection    0   // default tab value is 0 (tab #1)

#define WHICH_TAB_PREF_KEY      @"kWhichTab"
#define TAB_BAR_ORDER_PREF_KEY  @"kTabBerOrder"

@implementation CocktailBookAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.viewController = [[CocktailBookViewController alloc] initWithNibName:@"CocktailBookViewController" bundle:nil];
    //self.window.rootViewController = self.viewController;
    
    CBTabBarViewController *tabBar = [[CBTabBarViewController alloc] init];
    
    CBCocktailListViewController *cocktailList = [[CBCocktailListViewController alloc] init];
    CBCocktailListNavigationController *cocktailNav = [[CBCocktailListNavigationController alloc] initWithRootViewController:cocktailList];
    //UITabBarItem *cocktailNavItem = [cocktailNav tabBarItem];
    //[cocktailNavItem setTitle:@"Cocktails"];
    cocktailNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Cocktails" image:nil tag:0];
    
    //CBCategoriesViewController *categoryList = [[CBCategoriesViewController alloc] init];
    //CBCocktailListNavigationController *categoryNav = [[CBCocktailListNavigationController alloc] initWithRootViewController:categoryList];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithObjects:cocktailNav, nil];
    [tabBar setViewControllers:viewControllers animated:NO];
    
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
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
