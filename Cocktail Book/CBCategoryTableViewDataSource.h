//
//  CBCategoryTableViewDataSource.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 15/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBCategoryTableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate> {
    NSArray *categories;
    NSArray *selectedCategories;
}

@property (nonatomic) NSArray *categories;
@property (nonatomic) NSArray *selectedCategories;

- (id)initWithCategories:(NSArray *)cats;

@end
