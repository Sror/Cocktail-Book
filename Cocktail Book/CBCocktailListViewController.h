//
//  CBCocktailListViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 15/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "CBCategoryTableViewDataSource.h"
#import "CBCocktailViewController.h"

@interface CBCocktailListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    CBCategoryTableViewDataSource *categoriesDataSource;
    BOOL filterByCategories;
    NSMutableArray *categoryListContent;
    
    IBOutlet UITableView *cocktailTableView;
}

@property (nonatomic, strong) IBOutlet CBCocktailViewController *cocktailView;
@property (nonatomic, strong) IBOutlet UITableView *cocktailTableView;

@property (nonatomic, strong) NSArray *listContent;
@property (nonatomic, strong) NSMutableArray *filteredListContent;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end
