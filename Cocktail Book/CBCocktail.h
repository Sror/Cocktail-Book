//
//  CBCocktail.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 17/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBCocktail : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desciption;
@property (nonatomic) NSArray *ingredients;
@property (nonatomic) NSString *method;
@property (nonatomic) NSString *drinkType;
@property (nonatomic) NSString *category;
@property (nonatomic) NSNumber *howManyIServe;

@property (nonatomic) BOOL isFavourite;

- (id)initWithName:(NSString *)n description:(NSString *)desc;
- (id)initFromDictionary:(NSDictionary *)dict;

- (NSDictionary *)dictionaryForCocktail;

@end
