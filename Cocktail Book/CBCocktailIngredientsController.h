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
    IBOutlet UITextView *descriptionField;
    IBOutlet UITextView *ingredientsListField;
    IBOutlet UITextView *servesTextView;
    IBOutlet UITextView *pageTextView;
    
    CBCocktail *cocktail;
}

@property (nonatomic) UITextView *descriptionField;
@property (nonatomic) UITextView *ingredientsListField;
@property (nonatomic) UITextView *servesTextView;
@property (nonatomic) UITextView *pageTextView;

- (id)initWithCocktail:(CBCocktail *)cktl;

@end
