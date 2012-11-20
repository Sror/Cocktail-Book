//
//  CBCocktailListViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 18/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBCocktailListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *cocktailList;

- (IBAction)testButton:(id)sender;

@end
