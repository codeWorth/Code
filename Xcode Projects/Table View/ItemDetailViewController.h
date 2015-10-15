//
//  ItemDetailViewController.h
//  Checklists
//
//  Created by Baby Andrew on 8/7/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void)ItemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void)ItemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
- (void)ItemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;

@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <ItemDetailViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) ChecklistItem *itemToEdit;
- (IBAction)cancelPressed;
- (IBAction)donePressed;

@end
