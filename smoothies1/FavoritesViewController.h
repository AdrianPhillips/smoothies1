//
//  FavoritesViewController.h
//  Smoothies
//
//  Created by Adrian Phillips on 7/22/11.
//  Copyright 2011 Home. All rights reserved.
//

@class DataModel;

/*
 * This is the view controller that lists the user's favorite recipes.
 */
@interface FavoritesViewController : UITableViewController
{
}

// We have a weak reference to the shared Data Model object
@property (nonatomic, assign) IBOutlet DataModel* dataModel;

@end
