//
//  ColorPeg.m
//  MastermindSolver
//
//  Created by Programming Account on 4/19/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "Peg.h"

@implementation Peg

-(BOOL)isEqual:(id)object{
    if ([object isKindOfClass:self.class]){
        Peg *other = object;
        if ([other.color isEqualToString:self.color] && self.isGuessPeg == other.isGuessPeg) {
            return YES;
        }
    }
    return NO;
}

@end
