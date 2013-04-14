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

@synthesize methodTextView, barTipTextView;

- (id)initWithCocktail:(CBCocktail *)cktl
{
    if (self = [super initWithNibName:@"CocktailMethod" bundle:nil]) {
        cocktail = cktl;
    }
    return self;
}

- (void)viewDidLoad
{
    [self setupMethod];
    [self setupBartendersTip];
}

- (void)setupMethod
{
    methodTextView.text = cocktail.method;
    
    [self resizeView:methodTextView];
}

- (void)setupBartendersTip
{
    if (![cocktail.bartendersTip isEqualToString:@"nil"])
        barTipTextView.text = [NSString stringWithFormat:@"BARTENDER'S TIP: %@", cocktail.bartendersTip];
    else
        barTipTextView.text = @"";
    
    [self alignView:barTipTextView belowView:methodTextView withAnimationTime:0.5 andOffset:10];
}

#pragma mark - UITextView Manipulation

- (void)resizeView:(UITextView *)view
{
    CGRect frame = view.frame;
    UIEdgeInsets inset = view.contentInset;
    frame.size.height = view.contentSize.height + inset.top + inset.bottom;
    view.frame = frame;
    [view sizeToFit];
}

- (void)alignView:(UITextView *)lowerView belowView:(UITextView *)upperView withAnimationTime:(float)time andOffset:(int)offset
{
    [UIView animateWithDuration:time animations:^{
        CGRect frame = lowerView.frame;
        CGRect dframe = upperView.frame;
        frame.origin.y = dframe.origin.y + dframe.size.height + offset;
        lowerView.frame = frame;
    }];
}

@end
