//
//  CBCocktailMethodController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 27/03/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBCocktailMethodController : UIViewController {
    IBOutlet UILabel *pageNumberLabel;
    int pageNumber;
}

@property (nonatomic, retain) UILabel *pageNumberLabel;
- (id)initWithPageNumber:(int)page;

@end
