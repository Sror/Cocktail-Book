//
//  CBCocktailListViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 15/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailListViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "CocktailBookAppDelegate.h"
#import "CBCocktailViewController.h"
#import "CBCocktail.h"
#import "CBCocktailListCell.h"

#import "PopoverView.h"

#define COCKTAIL_CELL_ID @"Cocktail_Cell"

@interface CBCocktailListViewController()
@property (nonatomic, strong) NSArray *cocktails;

- (void)populateCocktails;
@end

@implementation CBCocktailListViewController

@synthesize cocktailView, cocktailTableView;
@synthesize cocktails, listContent, filteredListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive;

- (id)init
{
    self = [super initWithNibName:@"CBCocktailListViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
    [self.navigationItem setTitle:@"COCKTAILS"];
    
    [self setupBarButtonsAndUIElements];
    [self setupCategories];
    
    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.cocktails count]];
    categoryListContent = [NSMutableArray arrayWithCapacity:[self.cocktails count]];
	
	// Restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm) {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    
    // Add NotificationCenter Observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryFilterChanged) name:@"CBCategoryFilterSelected" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.cocktailTableView indexPathForSelectedRow];
	[self.cocktailTableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    [self populateCocktails];
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

- (void)viewDidAppear:(BOOL)animated
{
    [self hideSearchBar];
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
    
    NSSortDescriptor *cocktailSortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]; // sort cocktails by name
    cocktails = [cocktails sortedArrayUsingDescriptors:[NSArray arrayWithObject:cocktailSortByName]];
}

- (void)hideSearchBar
{
    [UIView beginAnimations:@"hidesearchbar" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.cocktailTableView.contentOffset = CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height);
    [UIView commitAnimations];
}

- (void)setupBarButtonsAndUIElements
{
    UIImage *menuBarImage = [UIImage imageNamed:@"white-menu-bar.png"];
    [[UINavigationBar appearance] setBackgroundImage:menuBarImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"arrow-west.png"];
    backButtonImage = [backButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 0.0f)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIButtonTypeCustom target: nil action: nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //self.navigationController.navigationBar.translucent = YES;
    /*
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10-light-background.jpg"]];
    [self.view addSubview:background];
     */
    [self.view addSubview:self.cocktailTableView];
    
    UIImage *settingsButtonImage = [UIImage imageNamed:@"martini.png"];
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.frame = CGRectMake(0.0f, 0.0f, settingsButtonImage.size.width + 20.0f, settingsButtonImage.size.height);
    [settingsButton setImage:settingsButtonImage forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(displayCategoryFilter) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sideBarButton = self.navigationItem.leftBarButtonItem;
    UIImage *leftButtonImage = [UIImage imageNamed:@"gear.png"];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0.0f, 0.0f, leftButtonImage.size.width + 20.0f, leftButtonImage.size.height);
    [leftButton setImage:leftButtonImage forState:UIControlStateNormal];
    [leftButton addTarget:sideBarButton.target action:sideBarButton.action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.cocktailTableView.backgroundColor = [UIColor clearColor];
    
    
    //UIColor *titleColor = [UIColor colorWithRed:150.0f/255.0f green:149.0f/255.0f blue:149.0f/255.0f alpha:1.0f];
    UIColor *shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Academy Engraved LET" size:24.0];
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:1.0f forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blackColor], UITextAttributeTextColor,
                                                          font, UITextAttributeFont, shadowColor, UITextAttributeTextShadowColor,
                                                          [NSValue valueWithCGSize:CGSizeMake(0.0,1.0)], UITextAttributeTextShadowOffset,
                                                          nil]];
    
    // Remove SearchBar background
    self.searchDisplayController.searchBar.backgroundImage = [UIImage imageNamed:@"blank.png"];
}

- (void)displayCategoryFilter
{
    CGPoint anchor = CGPointMake(self.view.frame.size.width, 0);
    
    CGRect frame = CGRectMake(anchor.x, anchor.y, 175, 200);
    UITableView *categoryList = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    categoryList.backgroundColor = [UIColor clearColor];
    categoryList.dataSource = categoriesDataSource;
    categoryList.delegate = categoriesDataSource;
    
    [PopoverView showPopoverAtPoint:anchor inView:self.view withContentView:categoryList delegate:nil];
}

- (void)setupCategories
{
    NSArray *cats = [[NSArray alloc] initWithObjects:@"Bubbles", @"Chic", @"Jungle Juice", @"Frou Frou",
                     @"Tropicana", @"Muddled", @"Club Lounge", @"Mellow",
                     @"Virginal", nil];
    categoriesDataSource = [[CBCategoryTableViewDataSource alloc] initWithCategories:cats];
    filterByCategories = NO;
}

- (void)categoryFilterChanged
{
    NSArray *cats = categoriesDataSource.selectedCategories;
    if ([cats count] > 0) {
        filterByCategories = YES;
    } else {
        filterByCategories = NO;
    }
    
    [categoryListContent removeAllObjects];
    for (CBCocktail *c in self.cocktails) {
        if ([cats containsObject:c.category]) {
            [categoryListContent addObject:c];
        }
    }
    [self.cocktailTableView reloadData];
    [self.cocktailTableView setNeedsDisplay];
}

- (void)clearCategoryFilter
{
    filteredListContent = NO;
    [categoryListContent removeAllObjects];
    [self.cocktailTableView reloadData];
}

#pragma mark -
#pragma mark UITableView Delegates
/*
 - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
 
 if(searchWasActive)
 return nil;
 
 return cocktailRegions;
 }
 
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 
 return [cocktailRegions objectAtIndex:section];
 }
 
 - (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
 
 if(searchWasActive)
 return -1;
 
 return index % 2;
 }
 
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 // Return the number of sections.
 return [cocktailRegions count];
 }
 
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredListContent count];
    } else if (filterByCategories) {
        return [categoryListContent count];
    } else {
        return [self.cocktails count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COCKTAIL_CELL_ID];
    CBCocktailListCell *cell = [tableView dequeueReusableCellWithIdentifier:COCKTAIL_CELL_ID];
    
    if (!cell) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:COCKTAIL_CELL_ID];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		//cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CBCocktailListTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Get the item for the cell and set the cell title to the title for the item.
    // In this case, get the cocktail for this cell and set the title as the cocktail name.
    // Other properties you may set are a description ... image for the cell ... etc. Or make a custom cell.
    CBCocktail *cocktail;
    
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        cocktail = [self.filteredListContent objectAtIndex:indexPath.row];
    } else if (filterByCategories) {
        cocktail =  [categoryListContent objectAtIndex:indexPath.row];
    } else {
        cocktail = [self.cocktails objectAtIndex:indexPath.row];
    }
    
    [cell.nameLabel setText:cocktail.name];
    [cell.drinkTypeLabel setText:cocktail.drinkType];
    [cell setCellLook];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
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

// Override to support custom cell size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

#pragma mark UITableView DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect row
    //[tableView deselectRowAtIndexPath:indexPath animated:YES]; // We now do this when the view is loaded
    
    CBCocktail *cocktail;
    
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        cocktail = [self.filteredListContent objectAtIndex:indexPath.row];
    } else if (filterByCategories) {
        cocktail = [categoryListContent objectAtIndex:indexPath.row];
    } else {
        cocktail = [self.cocktails objectAtIndex:indexPath.row];
    }
    
    cocktailView.title = cocktail.name;
    [cocktailView setCocktail:cocktail];
    
	[self.navigationController pushViewController:cocktailView animated:YES];
    /*
    [cocktailView viewWillAppear:YES];
    [UIView transitionFromView:self.view
                        toView:cocktailView.view
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCurlUp
                    completion:^(BOOL finished) {
                        // Do something... or not...
                        [cocktailView viewDidAppear:YES];
                        [self.navigationController pushViewController:cocktailView animated:NO];
                    }];
     */
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

@end
