//
//  editProfileViewController.h
//  MultiuserTest
//
//  Created by Programming Account on 5/31/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <UIKit/UIKit.h>
@class multiuserTestViewController;

@interface editProfileViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) multiuserTestViewController *sender;

-(void)updateUI;

@end
