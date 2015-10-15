//
//  StartPageViewController.h
//  BullsEye
//
//  Created by FatherofAndrew on 7/30/13.
//  Copyright (c) 2013 AwesomeAndrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)startOver;
- (IBAction)showInfo;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;

@end
