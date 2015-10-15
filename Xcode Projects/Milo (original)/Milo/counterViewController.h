//
//  counterViewController.h
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "KeyFobDelegate.h"
@class challengeViewController;

@interface counterViewController : UIViewController <UIApplicationDelegate,KeyFobDelegateDelegate>

@property (nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *activityLogs;

+(void)updateScoreForChallenge:(challengeViewController *)view;
+(void)updateScoreForCounter:(counterViewController *)view;

@end
