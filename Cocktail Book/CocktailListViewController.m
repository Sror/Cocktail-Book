//
//  CocktailListViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CocktailListViewController.h"
#import "CBCocktailViewController.h"
#import "CBCocktail.h"

#define COCKTAIL_CELL_ID @"Cocktail_Cell"

@interface CocktailListViewController()
@property (nonatomic, strong) NSArray *cocktails;

- (void)populateCocktails;
@end

@implementation CocktailListViewController

@synthesize cocktails;
@synthesize cocktailView;

// this is called when its tab is first tapped by the user
- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self populateCocktails];
    [self.navigationItem setTitle:@"Cocktails"];
}

- (void)viewDidUnload {
	[super viewDidUnload];
    
	self.cocktails = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    self.cocktails = nil;
}

- (void)populateCocktails
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    CBCocktail *cocktail = [[CBCocktail alloc] initWithName:@"Gin & Tonic" description:@"The classic"];
    [list addObject:cocktail];
    cocktail = [[CBCocktail alloc] initWithName:@"Mai Tai" description:@"Smooth tropical drink"];
    [list addObject:cocktail];
    
    cocktails = [list copy];
}

#pragma mark - AppDelegate methods

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
}

#pragma mark -
#pragma mark UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cocktails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COCKTAIL_CELL_ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:COCKTAIL_CELL_ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    // Get the item for the cell and set the cell title to the title for the item.
    // In this case, get the cocktail for this cell and set the title as the cocktail name.
    // Other properties you may set are a description ... image for the cell ... etc. Or make a custom cell.
    CBCocktail *cocktail = [cocktails objectAtIndex:[indexPath row]];
    [cell.textLabel setText:cocktail.name];
    [cell.detailTextLabel setText:cocktail.desciption];
    
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

#pragma mark UITableView DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect row
    //[tableView deselectRowAtIndexPath:indexPath animated:YES]; // We now do this when the view is loaded
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cocktailView.title = cell.textLabel.text;
    
    CBCocktail *tappedCocktail = [cocktails objectAtIndex:indexPath.row];
    [cocktailView setCocktail:tappedCocktail];
    
	[self.navigationController pushViewController:cocktailView animated:YES];
}

#pragma mark -
#pragma mark UIViewControllerRotation
// Deprecated
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES; // support all orientations
}
 */

@end
