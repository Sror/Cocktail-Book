//
//  CocktailListViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCategoryTableViewDataSource.h"

@class CBCocktailViewController;

@interface CocktailListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    CBCategoryTableViewDataSource *categoriesDataSource;
    BOOL filterByCategories;
    NSMutableArray *categoryListContent;
}

@property (nonatomic, strong) IBOutlet CBCocktailViewController *cocktailView;

@property (nonatomic, strong) NSArray *listContent;
@property (nonatomic, strong) NSMutableArray *filteredListContent;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@end
