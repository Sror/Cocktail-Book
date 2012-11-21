//
//  FavouritesViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 21/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavouritesViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *favourites;

@end
