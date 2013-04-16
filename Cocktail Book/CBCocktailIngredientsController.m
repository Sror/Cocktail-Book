//
//  CBCocktailIngredientsController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 27/03/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailIngredientsController.h"
#import "CBCocktail.h"

@implementation CBCocktailIngredientsController : UIViewController

@synthesize ingredientsListField, descriptionField, servesTextView, pageTextView;

- (id)initWithCocktail:(CBCocktail *)cktl
{
    if (self = [super initWithNibName:@"CocktailIngredients" bundle:nil]) {
        cocktail = cktl;
    }
    return self;
}

- (void)viewDidLoad
{
    //[self setupUIElements];
    [self setupDescription];
    [self setupIngredientsList];
    [self setupNumServed];
    [self setupPage];
}

- (void)setupUIElements
{
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)setupIngredientsList
{
    NSString *ingredientList = @"";
    
    for (NSDictionary *ingredientDict in cocktail.ingredients) {
        NSString *ingredientName = [ingredientDict objectForKey:@"name"];
        NSString *ingredientNote = [ingredientDict objectForKey:@"note"];
        NSString *ingredientQuantity = [ingredientDict objectForKey:@"quantity"];
        NSString *ingredientString = @""; // @"\u2022 "
        
        if (![ingredientQuantity isEqualToString:@"nil"]) {
            ingredientString = [ingredientString stringByAppendingString:[NSString stringWithFormat:@"%@ ",ingredientQuantity]];
        }
        if (![ingredientName isEqualToString:@"nil"]) {
            ingredientString = [ingredientString stringByAppendingString:[NSString stringWithFormat:@"%@ ",ingredientName]];
        }
        if (![ingredientNote isEqualToString:@"nil"]) {
            ingredientString = [ingredientString stringByAppendingString:[NSString stringWithFormat:@"\n \t %@", ingredientNote]];
        }
        ingredientString = [ingredientString stringByAppendingString:@" \n"];
        ingredientList = [ingredientList stringByAppendingString:ingredientString];
    }
    
    ingredientsListField.text = ingredientList;
    
    // Move the view down.
    CGRect frame = ingredientsListField.frame;
    UIEdgeInsets inset = ingredientsListField.contentInset;
    frame.size.height = ingredientsListField.contentSize.height + inset.top + inset.bottom;
    ingredientsListField.frame = frame;
    [ingredientsListField sizeToFit];
     
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = ingredientsListField.frame;
        CGRect dframe = descriptionField.frame;
        frame.origin.y = dframe.origin.y + dframe.size.height + 10;
        ingredientsListField.frame = frame;
    }];
}

- (void)setupDescription
{
    descriptionField.text = cocktail.desciption;
    
    CGRect frame = descriptionField.frame;
    UIEdgeInsets inset = descriptionField.contentInset;
    frame.size.height = descriptionField.contentSize.height + inset.top + inset.bottom;
    descriptionField.frame = frame;
    [descriptionField sizeToFit];
}

- (void)setupNumServed
{
    servesTextView.text = [NSString stringWithFormat:@"SERVES: %@", cocktail.howManyIServe];
    
    [self resizeView:servesTextView];
    [self alignView:servesTextView belowView:ingredientsListField withAnimationTime:0.75 andOffset:-10];
}

- (void)setupPage
{
    pageTextView.text = [NSString stringWithFormat:@"%@  \u2022  PAGE IN BOOK: %@", cocktail.category, cocktail.pageInBook];
    
    [self resizeView:pageTextView];
    [self alignView:pageTextView belowView:servesTextView withAnimationTime:1.0 andOffset:0];
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
