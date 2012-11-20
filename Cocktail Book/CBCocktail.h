//
//  CBCocktail.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 17/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBCocktail : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desciption;
@property (nonatomic, copy) NSDictionary *ingredients;

- (id)initWithName:(NSString *)n description:(NSString *)desc;

@end
