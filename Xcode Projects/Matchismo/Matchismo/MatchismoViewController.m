//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Programming Account on 1/3/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "MatchismoViewController.h"

@interface MatchismoViewController ()

@end

@implementation MatchismoViewController


- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        [sender setTitle:@"A♣" forState:UIControlStateNormal];
    }
    
}

@end
