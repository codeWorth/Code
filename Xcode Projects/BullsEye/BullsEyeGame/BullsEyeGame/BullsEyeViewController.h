//
//  BullsEyeViewController.h
//  BullsEyeGame
//
//  Created by Baby Andrew on 8/4/13.
//  Copyright (c) 2013 Baby Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BullsEyeViewController : UIViewController

-(IBAction)zenMode;
-(IBAction)accuracyMode;
@property(strong, nonatomic)NSString *gameMode;

@end
