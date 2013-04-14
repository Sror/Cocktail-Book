//
//  CBCocktailMethodController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 27/03/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBCocktail.h"

@interface CBCocktailMethodController : UIViewController {
    IBOutlet UITextView *methodTextView;
    IBOutlet UITextView *barTipTextView;
    
    CBCocktail *cocktail;
}

@property (nonatomic) UITextView *methodTextView;
@property (nonatomic) UITextView *barTipTextView;

- (id)initWithCocktail:(CBCocktail *)cktl;

@end
