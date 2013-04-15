//
//  CBAboutViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 15/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBAboutViewController.h"

@interface CBAboutViewController ()

@end

@implementation CBAboutViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavTitle
{
    [self.navigationItem setTitle:@"About"];
}

@end
