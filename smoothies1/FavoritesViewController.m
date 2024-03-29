//
//  FavoritesViewController.m
//  Smoothies
//
//  Created by Adrian Phillips on 7/22/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "FavoritesViewController.h"
#import "DataModel.h"
#import "Recipe.h"
#import "RecipeDetailsViewController.h"

@implementation FavoritesViewController

@synthesize dataModel;

- (void)viewDidLoad
{
	[super viewDidLoad];
    
	// Set the height of the table view rows
	self.tableView.rowHeight = 66;
    
	// Start listening for notifications
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(favoritesChanged:)
                                                 name:FavoritesChangedNotification
                                               object:nil];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
    
	// Stop listening for notifications
	[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:FavoritesChangedNotification
                                                  object:nil];
}

- (void)dealloc
{
	// Stop listening for notifications
	[[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:FavoritesChangedNotification
                                                  object:nil];
    
	[super dealloc];
}

- (void)favoritesChanged:(NSNotification*)notification
{
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of favorites
	return [self.dataModel favoritesCount];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString* CellIdentifier = @"RecipeCellIdentifier";
    
	// Obtain a table view cell for this row
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
	// Get the favorite Recipe from the list
	Recipe* recipe = [self.dataModel.sortedFavorites objectAtIndex:indexPath.row];
    
	// Put the Recipe data into the cell
	cell.textLabel.text = recipe.name;
	cell.imageView.image = recipe.image;
    
	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    // Tell the Recipe Details screen which Recipe it should display
	Recipe* recipe = [self.dataModel.sortedFavorites objectAtIndex:indexPath.row];
    
    
    RecipeDetailsViewController *controller = segue.destinationViewController;
    controller.dataModel = self.dataModel;
    controller.recipe = recipe;
}

@end
