//
//  CBAboutViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 15/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBAboutViewController.h"

@interface CBAboutViewController ()
- (void)setupNavTitle;
- (void)setupUIElements;
@end

@implementation CBAboutViewController

@synthesize scrollView;

- (id)init
{
    self = [super initWithNibName:@"CBAboutViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupNavTitle];
    [self setupUIElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavTitle
{
    [self.navigationItem setTitle:@"ABOUT"];
}

- (void)setupUIElements
{
    //UIImage *menuBarImage = [UIImage imageNamed:@"10-light-menu-bar.png"];
    UIImage *backButtonImage = [UIImage imageNamed:@"arrow-west.png"];
    
    UIBarButtonItem *sideBarButton = self.navigationItem.leftBarButtonItem;
    UIImage *leftButtonImage = [UIImage imageNamed:@"gear.png"];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0.0f, 0.0f, leftButtonImage.size.width + 20.0f, leftButtonImage.size.height);
    [leftButton setImage:leftButtonImage forState:UIControlStateNormal];
    [leftButton addTarget:sideBarButton.target action:sideBarButton.action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    //[[UINavigationBar appearance] setBackgroundImage:menuBarImage forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIButtonTypeCustom target: nil action: nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    backButtonImage = [backButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 30.0f, 0.0f, 0.0f)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //self.navigationController.navigationBar.translucent = YES;
    
    //UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10-light-background.jpg"]];
    //[self.view addSubview:background];
    
    [self.view addSubview:scrollView];
    /*
    UIImage *settingsButtonImage = [UIImage imageNamed:@"10-light-settings-button.png"];
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.frame = CGRectMake(0.0f, 0.0f, settingsButtonImage.size.width + 20.0f, settingsButtonImage.size.height);
    [settingsButton setImage:settingsButtonImage forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(displayCategoryFilter) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    self.cocktailTableView.backgroundColor = [UIColor clearColor];
    */
}

@end
