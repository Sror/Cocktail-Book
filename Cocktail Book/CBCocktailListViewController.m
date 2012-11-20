//
//  CBCocktailListViewController.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 18/11/2012.
//  Copyright (c) 2012 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCocktailListViewController.h"
#import "CBCocktail.h"
#import "CBCocktailViewController.h"

#define CELL_IDENT @"CocktailListTableViewCell"

@interface CBCocktailListViewController ()

@end

@implementation CBCocktailListViewController

@synthesize cocktailList = _cocktailList;
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self populateCocktailList];
    [self.navigationItem setTitle:@"Cocktails"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateCocktailList
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    CBCocktail *cocktail = [[CBCocktail alloc] initWithName:@"Gin & Tonic" description:@"The classic"];
    [list addObject:cocktail];
    cocktail = [[CBCocktail alloc] initWithName:@"Mai Tai" description:@"Smooth tropical drink"];
    [list addObject:cocktail];
    
    self.cocktailList = [list copy];
}

- (IBAction)testButton:(id)sender
{
    NSLog(@"I am a test button.");
}

#pragma mark -
#pragma mark TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cocktailList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENT];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL_IDENT];
    }
    
    // Get the item for the cell and set the cell title to the title for the item.
    // In this case, get the cocktail for this cell and set the title as the cocktail name.
    // Other properties you may set are a description ... image for the cell ... etc. Or make a custom cell.
    CBCocktail *cocktail = [self.cocktailList objectAtIndex:[indexPath row]];
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

#pragma mark TableView Data Source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Declare the view controller
    //UIViewController *vc = nil;
    CBCocktailViewController *vc = [[CBCocktailViewController alloc] init];
    
    // Determine the row/section on the tapped cell
    /*
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: {
                    // initialize and allocate a specific view controller for section 0 row 0
                    vc = [[UIViewController alloc] init];
                    break;
                }
                case 1: {
                    // initialize and allocate a specific view controller for section 0 row 1
                    vc = [[UIViewController alloc] init];
                    break;
                }
            }
            break;
        case 1: {
            // initialize and allocate a specific view controller for section 1 ALL rows
            vc = [[UIViewController alloc] init];
            break;
        }
    }
    */
    
    // Get cell textLabel string to use in new view controller title
    NSString *cellTitleText = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    
    // Get object at the tapped cell index from table data source array to display in title
    CBCocktail *tappedCocktail = [self.cocktailList objectAtIndex:indexPath.row];
    [vc setCocktail:tappedCocktail];
    
    // Set title indicating what row/section was tapped
    [vc setTitle:cellTitleText];
    
    // present it modally (not necessary, but sometimes looks better then pushing it onto the stack - depending on your App)
    //[vc setModalPresentationStyle:UIModalPresentationFormSheet];
    
    // Have the transition do a horizontal flip - my personal fav
    //[vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    // The method `presentModalViewController:animated:` is depreciated in iOS 6 so use `presentViewController:animated:completion:` instead.
    //[self.navigationController presentViewController:vc animated:YES completion:NULL];
    
    [[self navigationController] pushViewController:vc animated:YES];
    
    // We are done with the view controller.  It is retained by self.navigationController so we can release it (if not using ARC)
    //[vc release], vc = nil;
}

@end
