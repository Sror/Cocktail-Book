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

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

#define LIST_CELL_ID @"SideMenuList"

@interface CBLeftPanelViewController ()

@end

@implementation CBLeftPanelViewController

@synthesize listContent;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableContents
{
    listContent = [NSArray arrayWithObjects:@"Cocktails", @"Guides", @"About", nil];
}

#pragma mark -
#pragma mark UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LIST_CELL_ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LIST_CELL_ID];
    }
    
    [[cell textLabel] setText:[listContent objectAtIndex:indexPath.row]];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark TableView Data Source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
