//
//  CBCategoryTableViewDataSource.m
//  Cocktail Book
//
//  Created by Ruaridh Sinclair Thomson on 15/04/2013.
//  Copyright (c) 2013 Ruaridh Sinclair Thomson. All rights reserved.
//

#import "CBCategoryTableViewDataSource.h"

#define CATEGORY_CELL_ID @"Category_Cell"

@implementation CBCategoryTableViewDataSource

@synthesize categories, selectedCategories;

- (id)initWithCategories:(NSArray *)cats {
    if (self = [super init]) {
        //categories = [cats copy];
        categories = [cats sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        selectedCategories = [NSArray array];
    }
    return self;
}

#pragma mark -
#pragma mark UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CATEGORY_CELL_ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CATEGORY_CELL_ID];
    }
    
    NSString *cellTitle = [categories objectAtIndex:indexPath.row];
    [cell.textLabel setText:cellTitle];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([selectedCategories containsObject:cellTitle])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont fontWithName:@"Cochin" size:16.0];
    cell.textLabel.font = font;
    
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
    return 32;
}

#pragma mark TableView Data Source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Deselect row
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *selectedCategory = [categories objectAtIndex:indexPath.row];
    
    NSMutableArray *cats = [selectedCategories mutableCopy];
    if ([cats containsObject:selectedCategory]) {
        [cats removeObject:selectedCategory];
    } else {
        [cats addObject:selectedCategory];
    }
    
    selectedCategories = [cats copy];
    
    [tableView reloadData];
    [tableView setNeedsDisplay];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"CBCategoryFilterSelected" object:nil]];
}

@end
