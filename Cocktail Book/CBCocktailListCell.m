//
//  CBCocktailListCell.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 16/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailListCell.h"

@implementation CBCocktailListCell

@synthesize nameLabel, drinkTypeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellLook
{
    UIFont *font = [UIFont fontWithName:@"Cochin" size:18.0];
    [nameLabel setFont:font];
    
    UIFont *font2 = [UIFont fontWithName:@"Cochin" size:12.0];
    [drinkTypeLabel setFont:font2];
}

@end
