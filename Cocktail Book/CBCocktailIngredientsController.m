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

@synthesize pageNumberLabel, ingredientsListField;

- (id)initWithCocktail:(CBCocktail *)cktl {
    if (self = [super initWithNibName:@"CocktailIngredients" bundle:nil])    {
        pageNumber = 0;
        cocktail = cktl;
    }
    return self;
}

- (void)viewDidLoad {
    pageNumberLabel.text = cocktail.name;
    
    [self setupIngredientsList];
}

- (void)setupIngredientsList
{
    NSString *ingredientList = @"";
    
    for (NSDictionary *ingredientDict in cocktail.ingredients) {
        NSString *ingredientName = [ingredientDict objectForKey:@"name"];
        NSString *ingredientNote = [ingredientDict objectForKey:@"note"];
        NSString *ingredientQuantity = [ingredientDict objectForKey:@"quantity"];
        NSString *ingredientString = @"\u2022 ";
        
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
}

@end
