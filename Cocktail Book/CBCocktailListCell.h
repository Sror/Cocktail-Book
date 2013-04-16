//
//  CBCocktailListCell.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 16/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBCocktailListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *drinkTypeLabel;

- (void)setCellLook;

@end
