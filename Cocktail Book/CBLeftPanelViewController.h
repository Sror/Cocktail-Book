//
//  CBLeftPanelViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 15/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBLeftPanelViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    
}

@property (nonatomic, strong) NSArray *listContent;

@end
