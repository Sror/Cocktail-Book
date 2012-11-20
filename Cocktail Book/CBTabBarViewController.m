//
//  CBTabBarViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBTabBarViewController.h"

@interface CBTabBarViewController ()

@end

@implementation CBTabBarViewController

@synthesize tabBar;
@synthesize viewControllers;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (id)init
{
    self = [super initWithNibName:@"CBTabBar" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /*
    NSArray *tabBarItemTitles = [NSArray arrayWithObjects: @"Title1", @"Title2", @"Title3", nil];
    //UITabBar *tabBar = [super tabBar];
    for (UITabBarItem *item in [super tabBar].items)
    {
        item.title = [tabBarItemTitles objectAtIndex: [[super tabBar].items indexOfObject: item]];
        
        NSLog(@"%@", [tabBarItemTitles objectAtIndex: [[super tabBar].items indexOfObject: item]]);
    }
     */
    
    NSLog(@"Number of tabbar items: %i", [[[super tabBar] items] count]);
    NSLog(@"Number of view controllers: %i", [self.viewControllers count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
