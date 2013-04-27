//
//  EditRecipeViewController.m
//  Smoothies
//
//  Created by Adrian Phillips on 7/22/11.
//  Copyright 2011 Home. All rights reserved.


// note to self: 1- add the dissmiss keyboard code to dismiss the keyboard
// 2- add better background images
// 4- better arrangements in detail text view,
// 5- add a start view
// 6- add autorotation
// 7- try using storuboard


#import "EditRecipeViewController.h"
#import "Recipe.h"
#import "DataModel.h"

@implementation EditRecipeViewController

@synthesize navigationBar, nameTextField, choosePhotoButton, delegate,
name, instructions, image, instructionsTextView, dataModel, recipe;


- (void)viewDidLoad
{
	[super viewDidLoad];
    
	// If a name is set, then we must be editing an existing recipe
	if (self.name != nil)
	{
		self.navigationBar.topItem.title = @"Edit Recipe";
		self.nameTextField.text = self.name;
	}
    if (self.instructions != nil)
	{
		self.navigationBar.topItem.title = @"Edit Recipe";
		self.instructionsTextView.text = self.instructions;
	}
	// If the recipe has an image, set it on the button
	if (self.image != nil)
		[self.choosePhotoButton setImage:self.image forState:UIControlStateNormal];
}

- (void)updateControls
{
	self.instructionsTextView.text = self.recipe.instructions;
    self.nameTextField.text = self.recipe.name;
}

- (void) didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	self.navigationBar = nil;
	self.nameTextField = nil;
	self.choosePhotoButton = nil;
}

- (void)dealloc
{
	[navigationBar release];
	[nameTextField release];
	[choosePhotoButton release];
	[name release];
	[instructions release];
	[image release];
	[super dealloc];
}

- (IBAction)cancel
{
	// Notify the delegate if it implements the optional method
	if ([self.delegate respondsToSelector:@selector(editRecipeDidCancel:)])
		[self.delegate editRecipeDidCancel:self];
    
	if ([[self parentViewController] respondsToSelector:@selector(dismissViewControllerAnimated:)]){
        
        [[self parentViewController] dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)save
{
	// Make sure the user has entered at least a recipe name
	if (self.nameTextField.text.length == 0)
	{
		UIAlertView* alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Whoops..."
                                  message:@"Please enter a recipe name"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
		
		[alertView show];
		[alertView release];
		return;
	}
    // Make sure the user has entered at least a recipe name
	if (self.instructionsTextView.text.length == 0)
	{
		UIAlertView* alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Whoops..."
                                  message:@"Please enter recipe instructions"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
		
		[alertView show];
		[alertView release];
		return;
	}
    
	self.name = self.nameTextField.text;
    self.instructions = self.instructionsTextView.text;
    
	// Notify the delegate and close the screen
	[self.delegate editRecipeDidSave:self];
	if ([[self parentViewController] respondsToSelector:@selector(dismissViewControllerAnimated:)]){
        
        [[self parentViewController] dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)choosePhoto
{
	// Show the image picker with the photo library
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
	[self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
	// We get here when the user has successfully picked an image.
	// Put the image in our property and set it on the button.
	self.image = [info objectForKey:UIImagePickerControllerEditedImage];
	[self.choosePhotoButton setImage:self.image forState:UIControlStateNormal];

	[self dismissViewControllerAnimated:YES completion:nil];
	[imagePicker release];
	imagePicker = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
	[self dismissViewControllerAnimated:YES completion:nil];
	[imagePicker release];
	imagePicker = nil;
}

@end
