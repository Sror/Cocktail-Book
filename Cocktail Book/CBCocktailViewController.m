//
//  CBCocktailViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 16/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailViewController.h"

@interface CBCocktailViewController ()

@end

@implementation CBCocktailViewController

@synthesize cocktail = _cocktail;
@synthesize contentView, ingredientView, methodView, similarView, segmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [contentView addSubview:ingredientView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationItem] setTitle:self.cocktail.name];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedControllerTouch:(id)sender
{
    int index = [segmentedControl selectedSegmentIndex];
    
    [self removeSubviews];
    if (index==0) {
        [contentView addSubview:ingredientView];
    } else if (index==1) {
        [contentView addSubview:methodView];
    } else if (index==2) {
        [contentView addSubview:similarView];
    }
}

- (void)removeSubviews
{
    NSArray *sub = [contentView subviews];
    for (UIView *v in sub) {
        [v removeFromSuperview];
    }
}

@end
