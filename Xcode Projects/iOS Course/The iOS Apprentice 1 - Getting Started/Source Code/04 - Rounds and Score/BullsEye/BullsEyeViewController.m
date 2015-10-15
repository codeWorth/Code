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
    int score;
    int round;
}

@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize roundLabel;

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}

- (void)startNewRound
{
    round += 1;
 
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
    int difference = abs(targetValue - currentValue);
    int points = 100 - difference;
    score += points;

    NSString *message = [NSString stringWithFormat:@"You scored %d points", points];

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
