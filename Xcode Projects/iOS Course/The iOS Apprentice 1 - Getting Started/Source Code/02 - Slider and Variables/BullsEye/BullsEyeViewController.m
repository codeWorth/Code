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

@implementation BullsEyeViewController {
    int currentValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentValue = 50;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)showAlert
{
    NSString *message = [NSString stringWithFormat:
        @"The value of the slider is: %d", currentValue];
 
    UIAlertView *alertView = [[UIAlertView alloc]
        initWithTitle:@"Hello, World!"
        message:message
        delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
 
    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)slider
{
    currentValue = lroundf(slider.value);
}

@end
