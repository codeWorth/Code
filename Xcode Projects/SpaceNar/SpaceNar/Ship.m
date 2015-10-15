//
//  Ship.m
//  SpaceNar
//
//  Created by Programming Account on 1/18/14.
//  Copyright (c) 2014 Baby Andrew. All rights reserved.
//

#import "Ship.h"

@interface Ship ()

+(void (^)(void))attackBlock;

@end

@implementation Ship

+(void (^)(void))attackBlock{
    void (^myBlock)(void) = ^(void){
    };
    NSLog(@"Please define your attack block if neccisary and comment out this line");
    return myBlock;
}

@end
