//
//  CocktailListViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 20/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CocktailBookAppDelegate.h"
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
@synthesize filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive;

// this is called when its tab is first tapped by the user
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	//[self populateCocktails];
    //NSString *title = @"Cocktails by M&S";
    [self.navigationItem setTitle:@"Cocktails by M&S"];
    
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.cocktails count]];
	
	// restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    
}

- (void)viewDidUnload
{
	[super viewDidUnload];
    
	self.cocktails = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    self.cocktails = nil;
}

- (void)populateCocktails
{
    CocktailBookAppDelegate *appDelegate = (CocktailBookAppDelegate *)[[UIApplication sharedApplication] delegate];
    cocktails = appDelegate.cocktails;
}

- (void)setTheme
{
    // Set navigation bar and bar button themes.
}

#pragma mark - AppDelegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    [self populateCocktails];
}

#pragma mark -
#pragma mark UITableView Delegates

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if(searchWasActive)
        return nil;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObject:@"A"];
    [tempArray addObject:@"B"];
    [tempArray addObject:@"C"];
    [tempArray addObject:@"D"];
    [tempArray addObject:@"E"];
    [tempArray addObject:@"F"];
    [tempArray addObject:@"G"];
    [tempArray addObject:@"H"];
    [tempArray addObject:@"I"];
    [tempArray addObject:@"J"];
    [tempArray addObject:@"K"];
    [tempArray addObject:@"L"];
    [tempArray addObject:@"M"];
    [tempArray addObject:@"N"];
    [tempArray addObject:@"O"];
    [tempArray addObject:@"P"];
    [tempArray addObject:@"Q"];
    [tempArray addObject:@"R"];
    [tempArray addObject:@"S"];
    [tempArray addObject:@"T"];
    [tempArray addObject:@"U"];
    [tempArray addObject:@"V"];
    [tempArray addObject:@"W"];
    [tempArray addObject:@"X"];
    [tempArray addObject:@"Y"];
    [tempArray addObject:@"Z"];
    
    return tempArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if(searchWasActive)
        return -1;
    
    return index % 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredListContent count];
    } else {
        return [self.cocktails count];
    }
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
    CBCocktail *cocktail;// = [cocktails objectAtIndex:[indexPath row]];
    
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        cocktail = [self.filteredListContent objectAtIndex:indexPath.row];
    } else {
        cocktail = [self.cocktails objectAtIndex:indexPath.row];
    }
    
    [cell.textLabel setText:cocktail.name];
    //[cell.detailTextLabel setText:cocktail.desciption];
    
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
    
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	//cocktailView.title = cell.textLabel.text;
    
    //CBCocktail *tappedCocktail = [cocktails objectAtIndex:indexPath.row];
    CBCocktail *cocktail; // = [cocktails objectAtIndex:[indexPath row]];
    
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        cocktail = [self.filteredListContent objectAtIndex:indexPath.row];
    } else {
        cocktail = [self.cocktails objectAtIndex:indexPath.row];
    }
    
    cocktailView.title = cocktail.name;
    [cocktailView setCocktail:cocktail];
    
	[self.navigationController pushViewController:cocktailView animated:YES];
}

#pragma mark - Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
	for (CBCocktail *cocktail in cocktails)
	{
        /*
		if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope])
		{
		}
         */
        NSComparisonResult result = [cocktail.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            [self.filteredListContent addObject:cocktail];
        }
	}
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark -
#pragma mark UIViewControllerRotation
// Deprecated
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES; // support all orientations
}
 */

@end
