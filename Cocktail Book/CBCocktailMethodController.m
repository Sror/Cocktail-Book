//
//  CBCocktailMethodController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 27/03/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailMethodController.h"

@implementation CBCocktailMethodController : UIViewController

@synthesize pageNumberLabel;

- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"CocktailMethod" bundle:nil])    {
        pageNumber = page;
    }
    return self;
}

- (void)viewDidLoad {
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
}

@end
