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
    int targetValue;
}

@synthesize slider;
@synthesize targetLabel;

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
}

- (void)startNewRound
{
    targetValue = 1 + (arc4random() % 100);
 
    currentValue = 50;
    self.slider.value = currentValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewRound];
    [self updateLabels];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)showAlert
{
    NSString *message = [NSString stringWithFormat:
        @"The value of the slider is: %d\nThe target value is: %d",
        currentValue, targetValue];

    UIAlertView *alertView = [[UIAlertView alloc]
        initWithTitle:@"Hello, World!"
        message:message
        delegate:nil
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
 
    [alertView show];

    [self startNewRound];
    [self updateLabels];
}

- (IBAction)sliderMoved:(UISlider *)sender
{
    currentValue = lroundf(sender.value);
}

@end
