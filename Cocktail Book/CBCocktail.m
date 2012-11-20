//
//  CBCocktail.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 17/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktail.h"

@interface CBCocktail()

@end

@implementation CBCocktail

@synthesize name = _name;
@synthesize desciption = _desciption;
@synthesize ingredients = _ingredients;

- (id)initWithName:(NSString *)n description:(NSString *)desc
{
    self = [super init];
    if (self) {
        self.name = n;
        self.desciption = desc;
    }
    return self;
}

@end
