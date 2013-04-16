//
//  CocktailBookAppDelegate.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CocktailBookAppDelegate.h"

#import "CBCocktail.h"
#import "CBCocktailListViewController.h"
#import "CBLeftPanelViewController.h"

#import "JASidePanelController.h"

#define kCustomiseTabBar        0   // compile time option to turn a custom tab bar on or off
#define kDefaultTabSelection    0   // default tab value is 0 (tab #1)

#define WHICH_TAB_PREF_KEY      @"kWhichTab"
#define TAB_BAR_ORDER_PREF_KEY  @"kTabBerOrder"

@interface CocktailBookAppDelegate ()

- (NSString *)cocktailStoragePath;
@end

@implementation CocktailBookAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize cocktails;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Set any data we need first
    [self loadCocktails];
    
    [self setAppTheme];
    
    CBCocktailListViewController *cocktailListController = [[CBCocktailListViewController alloc] init];
    CBLeftPanelViewController *leftPanelController = [[CBLeftPanelViewController alloc] init];
    
    self.viewController = [[JASidePanelController alloc] init];
    self.viewController.leftPanel = leftPanelController;
    self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:cocktailListController];
    //self.viewController.rightPanel = cocktailListController; //[[JARightViewController alloc] init];
    
    self.window.rootViewController = self.viewController;
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
    [self saveCocktails];
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
    //[self saveTabOrder];
    [self saveCocktails];
}

#pragma mark - App Theme

- (void)setAppTheme
{
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"10-light-menu-bar.png"] forBarMetrics:UIBarMetricsDefault];
    
}

#pragma mark - Multitasking

- (void)loadCocktails
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *coc;
    if ([manager fileExistsAtPath:[self cocktailStoragePath]]) {
        coc = [[NSArray alloc] initWithContentsOfFile:[self cocktailStoragePath]];
    } else {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cocktails" ofType:@"xml"];
        NSLog(@"%@",filePath);
        coc = [[NSArray alloc] initWithContentsOfFile:filePath];
    }
    
    NSMutableArray *cocs = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in coc) {
        CBCocktail *ct = [[CBCocktail alloc] initFromDictionary:dic];
        [cocs addObject:ct];
    }
    
    cocktails = [cocs copy];
}

- (void)saveCocktails
{
    NSMutableArray *coc = [[NSMutableArray alloc] init];
    
    for (CBCocktail *ct in cocktails) {
        NSDictionary *dic = [ct dictionaryForCocktail];
        [coc addObject:dic];
    }
    [coc writeToFile:[self cocktailStoragePath] atomically:YES];
}

- (NSString *)cocktailStoragePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *storagePath = [documentDirectory stringByAppendingPathComponent:@"cocktails.archive"];
    return storagePath;
}

#pragma mark -
#pragma mark UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	// store the selected tab for next time:
	//		normally we can do this at "applicationDidTerminate", but this is a convenient spot
	// note: if the user has the "More" tab selected, then the value stored is "NSNotFound"
	//
	[[NSUserDefaults standardUserDefaults] setInteger:[tabBarController selectedIndex] forKey:WHICH_TAB_PREF_KEY];
}


#pragma mark -
#pragma mark UINavigationControllerDelegate (More screen)

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

@end
