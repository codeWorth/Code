//
//  BullsEyeViewController.m
//  BullsEyeGame
//
//  Created by Baby Andrew on 8/4/13.
//  Copyright (c) 2013 Baby Andrew. All rights reserved.
//

#import "BullsEyeViewController.h"
#import "GameViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController

@synthesize gameMode = _gameMode;

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

-(NSString *)gameMode
{
    return _gameMode;
}

-(void)setGameMode:(NSString *)gameMode
{
    if ([gameMode isEqual: @"Zen"] || [gameMode isEqual: @"Accuracy"]) {
        _gameMode = gameMode;
    }
}

-(IBAction)zenMode
{
    self.gameMode = @"Zen";
    GameViewController *controller = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)accuracyMode
{
    self.gameMode = @"Accuracy";
    GameViewController *controller = [[GameViewController alloc]initWithNibName:@"GameViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
