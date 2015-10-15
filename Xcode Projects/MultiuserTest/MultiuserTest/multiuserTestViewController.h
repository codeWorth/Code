//
//  multiuserTestViewController.h
//  MultiuserTest
//
//  Created by Programming Account on 5/26/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetHandler.h"
@class editProfileViewController;

@interface multiuserTestViewController : UIViewController <NetHandlerDelegate>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) UIImage *image;

-(void)updateUI;

@end
