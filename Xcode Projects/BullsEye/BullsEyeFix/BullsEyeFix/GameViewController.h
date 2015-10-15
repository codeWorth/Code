//
//  GameViewController.h
//  BullsEyeFix
//
//  Created by Baby Andrew on 8/4/13.
//  Copyright (c) 2013 Baby Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)startOver;
- (IBAction)showInfo;
- (IBAction)toHomepage;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;
@property (strong, nonatomic) NSString *gameMode;

@end
