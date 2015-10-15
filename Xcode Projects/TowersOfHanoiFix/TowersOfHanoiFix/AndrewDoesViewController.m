//
//  AndrewDoesViewController.m
//  TowersOfHanoiFix
//
//  Created by Programming Account on 1/5/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "AndrewDoesViewController.h"

@interface AndrewDoesViewController ()

@property (weak, nonatomic) IBOutlet UITextField *numOfRings;
@property(nonatomic, strong)HanoiGameLogic *game;
@property (weak, nonatomic) IBOutlet UIButton *solveButtonOutlet;

@end

@implementation AndrewDoesViewController

- (IBAction)solveButton {
    self.game = [[HanoiGameLogic alloc]initWithRings:[self.numOfRings.text integerValue]];
    //NSArray *history =
    [self.game towerSolve];
    /* for (NSString *currentGame in history) {
        NSLog(@"%@", currentGame);
    }*/
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.numOfRings.delegate = self;
    CALayer *btnLayer = [self.solveButtonOutlet layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
}

@end
