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
    IBOutlet UILabel *pageNumberLabel;
    IBOutlet UITextView *methodTextView;
    
    int pageNumber;
    CBCocktail *cocktail;
}

@property (nonatomic, retain) UILabel *pageNumberLabel;
@property (nonatomic) UITextView *methodTextView;

- (id)initWithCocktail:(CBCocktail *)cktl;

@end
