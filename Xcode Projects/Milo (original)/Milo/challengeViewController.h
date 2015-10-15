//
//  challengeViewController.h
//  Milo
//
//  Created by Programming Account on 1/16/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "KeyFobDelegate.h"

@interface challengeViewController : UIViewController <UIApplicationDelegate,KeyFobDelegateDelegate>

@property (nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *activityLogs;

-(void)updateScore;

@end
