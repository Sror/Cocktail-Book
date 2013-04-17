//
//  CBLeftPanelListCell.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 17/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBLeftPanelListCell.h"

@implementation CBLeftPanelListCell

@synthesize nameLabel, iconView, disclosureIconView, dividerView, bgView;

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
    bgView.hidden = !selected;
    //NSLog(@"Selected: %@ %@", nameLabel.text, [NSNumber numberWithBool:selected]);
}

@end
