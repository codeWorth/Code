//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Matthijs Hollemans on 01-06-12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "BullsEyeViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showAlert
{
    UIAlertView *alertView = [[UIAlertView alloc]
        initWithTitle:@"Hello, World"
        message:@"This is my first app!"
        delegate:nil
        cancelButtonTitle:@"Awesome"
        otherButtonTitles:nil];
 
    [alertView show];
}

@end
