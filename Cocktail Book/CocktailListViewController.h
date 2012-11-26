//
//  CocktailListViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBCocktailViewController;

@interface CocktailListViewController : UITableViewController

@property (nonatomic, strong) IBOutlet CBCocktailViewController *cocktailView;

- (void)setTheme;

@end
