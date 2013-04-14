//
//  CBCocktailMethodController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 27/03/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailMethodController.h"
#import "CBCocktail.h"

@implementation CBCocktailMethodController : UIViewController

@synthesize pageNumberLabel, methodTextView;

- (id)initWithCocktail:(CBCocktail *)cktl {
    if (self = [super initWithNibName:@"CocktailMethod" bundle:nil])    {
        pageNumber = 1;
        cocktail = cktl;
    }
    return self;
}

- (void)viewDidLoad {
    pageNumberLabel.text = @"Method";
    
    [self setupMethod];
}

- (void)setupMethod
{
    methodTextView.text = cocktail.method;
    NSLog(@"%@", cocktail.method);
}

@end
