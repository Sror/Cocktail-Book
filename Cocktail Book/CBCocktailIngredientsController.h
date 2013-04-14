//
//  CBCocktailIngredientsController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 27/03/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCocktail.h"

@interface CBCocktailIngredientsController : UIViewController {
    IBOutlet UILabel *pageNumberLabel;
    IBOutlet UITextView *ingredientsListField;
    int pageNumber;
    
    CBCocktail *cocktail;
    
    NSString *cocktailName;
}

@property (nonatomic, retain) UILabel *pageNumberLabel;
@property (nonatomic) UITextView *ingredientsListField;

- (id)initWithCocktail:(CBCocktail *)cktl;

@end
