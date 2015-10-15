//
//  StartPageViewController.m
//  BullsEye
//
//  Created by FatherofAndrew on 7/30/13.
//  Copyright (c) 2013 AwesomeAndrew. All rights reserved.
//

#import "GameViewController.h"
#import "BullsEyeViewController.h"
#import "AboutViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface GameViewController ()

@end

@implementation GameViewController

{
    int currentValue;
    int targetValue;
    int score;
    int round;
}

@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize roundLabel;

- (void)startNewRound
{
    round += 1;
    currentValue = 50;
    self.slider.value = currentValue;
    targetValue = 1 + (arc4random() % 100);
}

- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewRound];
    [self updateLabels];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startOver{
    round = 0;
    score = 0;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self startNewRound];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)showAlert
{
    int difference = abs(currentValue - targetValue);
    int points = 100 - difference;
    if (difference == 0) {
        points += 100;
    } else if (difference < 2){
        points += 50;
    } else if (difference > 97){
        points += 300;
    }
    score += points;
    NSString *title;
    if (difference == 0) {
        title = @"Perfect!";
    } else if (difference < 5){
        title = @"Very Close!";
    } else if (difference < 15){
        title = @"Pretty Good.";
    } else if (difference < 50){
        title = @"Not a total failure!";
    } else if (difference <90){
        title = @"Terrible.";
    } else {
        title = @"?????????";
    }
    
    NSString *message = [NSString stringWithFormat:@"You got %d points", points];
    
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



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}

- (IBAction)showInfo
{
    AboutViewController *controller = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)viewDidUnload {
    [self setRoundLabel:nil];
    [super viewDidUnload];
}
@end
