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

- (void)startNewGame
{
    score = 0;
    round = 0;
    [self startNewRound];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewGame];
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
 
    NSString *title;
    if (difference == 0) {
        title = @"Perfect!";
        points += 100;
    } else if (difference < 5) {
        if (difference == 1) {
            points += 50;
        }
        title = @"You almost had it!";
    } else if (difference < 10) {
        title = @"Pretty good!";
    } else {
        title = @"Not even close...";
    }
 
    score += points;
 
    NSString *message = [NSString stringWithFormat:@"You scored %d points", points];
 
    UIAlertView *alertView = [[UIAlertView alloc]
        initWithTitle:title
        message:message
        delegate:self
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];

    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)sender
{
    currentValue = lroundf(sender.value);
}

- (IBAction)startOver
{
    [self startNewGame];
    [self updateLabels];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}

@end
