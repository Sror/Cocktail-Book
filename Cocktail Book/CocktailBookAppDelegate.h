//
//  CocktailBookAppDelegate.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JASidePanelController.h"

@class CocktailBookViewController;

@interface CocktailBookAppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet JASidePanelController *viewController;

@property (strong, nonatomic) NSArray *cocktails;

- (void)loadCocktails;
- (void)saveCocktails;

@end
