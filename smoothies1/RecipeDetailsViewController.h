//
//  RecipeDetailsViewController.h
//  Smoothies
//
//  Created by Adrian Phillips on 7/22/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "EditRecipeViewController.h"

@class DataModel;
@class Recipe;


@interface RecipeDetailsViewController : UIViewController <EditRecipeDelegate>
{
}

@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UITextView* instructionsTextView;
@property (nonatomic, retain) IBOutlet UIButton* favoriteButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* editButton;


@property (nonatomic, assign) DataModel* dataModel;
@property (nonatomic, retain) Recipe* recipe;

- (IBAction)favoriteTapped;
- (IBAction)editRecipe;

@end

