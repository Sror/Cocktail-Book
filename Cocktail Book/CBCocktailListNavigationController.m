//
//  CBCocktailListNavigationController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailListNavigationController.h"

@interface CBCocktailListNavigationController ()

@end

@implementation CBCocktailListNavigationController

- (id)init
{
    self = [super initWithNibName:@"CBCocktailListNavContView" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
