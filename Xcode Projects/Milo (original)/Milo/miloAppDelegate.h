//
//  miloAppDelegate.h
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KeyFobDelegate.h"

@interface miloAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) KeyFobDelegate *d;

@end
