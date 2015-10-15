//
//  BullsEyeViewController.m
//  BullsEyeFix
//
//  Created by Baby Andrew on 8/4/13.
//  Copyright (c) 2013 Baby Andrew. All rights reserved.
//

#import "BullsEyeViewController.h"
#import "GameViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)zenMode
{
    GameViewController *controller = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    controller.gameMode = @"Zen";
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)accuracyMode
{
    GameViewController *controller = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    controller.gameMode = @"Accuracy";
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}


@end
