//
//  BullsEyeViewController.h
//  BullsEye
//
//  Created by FatherofAndrew on 7/21/13.
//  Copyright (c) 2013 AwesomeAndrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BullsEyeViewController : UIViewController <UIAlertViewDelegate>

-(IBAction)zenMode;
-(IBAction)accuracyMode;
@property(strong, nonatomic)NSString *gameMode;

@end
