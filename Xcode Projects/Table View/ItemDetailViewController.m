//
//  ItemDetailViewController.m
//  Checklists
//
//  Created by Baby Andrew on 8/7/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize itemToEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.textField becomeFirstResponder];
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    
    return YES;
}

- (IBAction)cancelPressed
{
    [self.delegate ItemDetailViewControllerDidCancel:self];
}

- (IBAction)donePressed
{
    if (self.itemToEdit != nil) {
        self.itemToEdit.text = self.textField.text;
        [self.delegate ItemDetailViewController:self didFinishEditingItem:itemToEdit];
    } else {
        ChecklistItem *item = [[ChecklistItem alloc]init];
        item.text = self.textField.text;
        item.checked = NO;
        [self.delegate ItemDetailViewController:self didFinishAddingItem:item];
    }
}

- (void)viewDidUnload {
    [self setDoneBarButton:nil];
    [super viewDidUnload];
}
@end
