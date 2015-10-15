//
//  KeyFobDelegate.h
//  Milo
//
//  Created by Programming Account on 2/7/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIBLECBKeyfob.h"

@protocol KeyFobDelegateDelegate <NSObject>

-(void) leftButtonPressed;
-(void) rightButtonPressed;

@end

@interface KeyFobDelegate : NSObject <TIBLECBKeyfobDelegate>

@property (strong, nonatomic) UIButton *TIBLEConnectBtn;

@property (strong, nonatomic) TIBLECBKeyfob *t;
@property (weak, nonatomic) id<KeyFobDelegateDelegate> delegate;

@end
