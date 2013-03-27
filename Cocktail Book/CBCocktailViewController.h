//
//  CBCocktailViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 16/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBCocktail.h"

@interface CBCocktailViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
}

@property (nonatomic) CBCocktail *cocktail;

@property (nonatomic) IBOutlet UIWindow *window;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSMutableArray *viewControllers;

@property (nonatomic) IBOutlet UIViewController *ingredientsController;
@property (nonatomic) IBOutlet UIViewController *methodController;
@property (nonatomic) IBOutlet UIViewController *similarController;

- (IBAction)changePage:(id)sender;

@end
