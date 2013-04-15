//
//  CocktailBookAppDelegate.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CocktailBookAppDelegate.h"

#import "CBCocktail.h"

#define kCustomiseTabBar        0   // compile time option to turn a custom tab bar on or off
#define kDefaultTabSelection    0   // default tab value is 0 (tab #1)

#define WHICH_TAB_PREF_KEY      @"kWhichTab"
#define TAB_BAR_ORDER_PREF_KEY  @"kTabBerOrder"

@interface CocktailBookAppDelegate ()

- (NSString *)cocktailStoragePath;
@end

@implementation CocktailBookAppDelegate

@synthesize window;
@synthesize myTabBarController;
@synthesize cocktails;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Set any data we need first
    [self loadCocktails];
    
    // test for "WHICH_TAB_PREF_KEY" key value
    NSUInteger testValue = [[NSUserDefaults standardUserDefaults] integerForKey:WHICH_TAB_PREF_KEY];
	if (testValue == 0) {
		// since no default values have been set (i.e. no preferences file created), create it here
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kDefaultTabSelection], WHICH_TAB_PREF_KEY, nil];
		[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
	}
    
	// re-store previously selected tab from prefs
	//
	// if the More navigation controller was last selected, you must change the value of the "selectedViewController" property instead.
	if ([[NSUserDefaults standardUserDefaults] integerForKey:WHICH_TAB_PREF_KEY] == NSNotFound) {
		self.myTabBarController.selectedViewController = self.myTabBarController.moreNavigationController;
	} else {
		self.myTabBarController.selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:WHICH_TAB_PREF_KEY];
	}
	
    
	// listen for changes in view controller from the More screen
	self.myTabBarController.moreNavigationController.delegate = self;
    
    
    [myTabBarController setSelectedIndex:1]; // Start on the cocktails view
    self.window.rootViewController = self.myTabBarController;
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
    [self saveTabOrder];
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
    [self saveTabOrder];
    [self saveCocktails];
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

- (void)saveTabOrder
{
	// store the tab-order to preferences
	//
	NSMutableArray* classNames = [[NSMutableArray alloc] init];
	for (UIViewController* controller in self.myTabBarController.viewControllers)
	{
		if ([controller isKindOfClass:[UINavigationController class]])
		{
			UINavigationController *navController = (UINavigationController *)controller;
			
			[classNames addObject:NSStringFromClass([navController.topViewController class])];
		}
		else
		{
			[classNames addObject:NSStringFromClass([controller class])];
		}
	}
	
	[[NSUserDefaults standardUserDefaults] setObject:classNames forKey:TAB_BAR_ORDER_PREF_KEY];
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
	if (viewController == [self.myTabBarController.moreNavigationController.viewControllers objectAtIndex:0])
	{
		// returned to the More page
	}
}

@end
