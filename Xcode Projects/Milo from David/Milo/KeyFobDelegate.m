//
//  KeyFobDelegate.m
//  Milo
//
//  Created by Programming Account on 2/7/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "KeyFobDelegate.h"

@implementation KeyFobDelegate

-(void) keyfobReady{
    [self.TIBLEConnectBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
    
    [self.t enableAccelerometer:[self.t activePeripheral]];   // Enable accelerometer (if found)
    [self.t enableButtons:[self.t activePeripheral]];         // Enable button service (if found)
    [self.t enableTXPower:[self.t activePeripheral]];
}

-(void) accelerometerValuesUpdated:(char)x y:(char)y z:(char)z{
    
}

-(void) TXPwrLevelUpdated:(char)TXPwr{
    
}

-(void) keyValuesUpdated:(char)sw{
    if (self.t.key1) {
        NSLog(@"Left button was pressed");
        [self.delegate leftButtonPressed];
    } else if (self.t.key2){
        NSLog(@"Right button was pressed");
        [self.delegate rightButtonPressed];
    }
}


@end
