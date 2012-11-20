//
//  CBTabBarViewController.h
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBTabBarViewController : UITabBarController

@property (nonatomic, readonly) IBOutlet UITabBar *tabBar;
@property (nonatomic, copy) NSArray *viewControllers;

@end
