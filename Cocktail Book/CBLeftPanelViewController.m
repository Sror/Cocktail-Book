//
//  CBLeftPanelViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 15/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBLeftPanelViewController.h"
#import "CBCocktailListViewController.h"
#import "CBAboutViewController.h"
#import "CBLeftPanelListCell.h"

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

#define LIST_CELL_ID @"SideMenuList"

@interface CBLeftPanelViewController () {
int selectedIndex;
}

- (void)setupTableContents;
- (void)setupUIElements;
@end

@implementation CBLeftPanelViewController

@synthesize listContent, listContentIcons, menuTableView;

- (id)init
{
    self = [super initWithNibName:@"CBLeftPanelViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableContents];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupUIElements];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableContents
{
    listContent = [NSArray arrayWithObjects:@"Cocktails", @"Guides", @"About", nil];
    listContentIcons = [NSArray arrayWithObjects:@"martini-dark.png", @"book.png", @"persondot.png", nil];
    
    [menuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)setupUIElements
{
    //[self.view setBackgroundColor:[UIColor clearColor]];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-background.jpg"]];
    [self.view addSubview:background];
    
    [menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [menuTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:menuTableView];
}

#pragma mark -
#pragma mark UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBLeftPanelListCell *cell = [tableView dequeueReusableCellWithIdentifier:LIST_CELL_ID];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CBLeftPanelListCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.nameLabel setText:[listContent objectAtIndex:indexPath.row]];
    [cell.iconView setImage:[UIImage imageNamed:[listContentIcons objectAtIndex:indexPath.row]]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

// Override to support custom cell size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark TableView Data Source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We would do something in page==1, if we were going to write all the guides.
    int page = indexPath.row;
    if (page==0) {
        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[CBCocktailListViewController alloc] init]];
    } else if (page==1) {
        //self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[CBAboutViewController alloc] init]];
    } else if (page==2) {
        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[CBAboutViewController alloc] init]];
    }
}

@end
