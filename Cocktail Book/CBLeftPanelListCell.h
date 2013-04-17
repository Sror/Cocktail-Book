//
//  CBLeftPanelListCell.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 17/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBLeftPanelListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *iconView;
@property (nonatomic, weak) IBOutlet UIImageView *disclosureIconView;
@property (nonatomic, weak) IBOutlet UIImageView *dividerView;
@property (nonatomic, weak) IBOutlet UIView *bgView;

@end
