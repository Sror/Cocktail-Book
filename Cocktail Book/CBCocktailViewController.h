//
//  CBCocktailViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 16/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBCocktail.h"

@interface CBCocktailViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic) CBCocktail *cocktail;

- (id)init;

@end
