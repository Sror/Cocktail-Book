//
//  CBCocktailViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 16/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBCocktail.h"

@interface CBCocktailViewController : UIViewController

@property (nonatomic) CBCocktail *cocktail;

@property (nonatomic) IBOutlet UIView *contentView;
@property (nonatomic) IBOutlet UIView *ingredientView;
@property (nonatomic) IBOutlet UIView *methodView;
@property (nonatomic) IBOutlet UIView *similarView;

@property (nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)segmentedControllerTouch:(id)sender;

@end
