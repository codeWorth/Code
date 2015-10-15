//
//  HanoiGame.m
//  TowersOfHanoiFix
//
//  Created by Programming Account on 1/6/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "HanoiGame.h"

@interface HanoiGame ()

@property(nonatomic, strong)NSArray *pins;
@property(nonatomic,strong)NSMutableString *reusedString;

@end

@implementation HanoiGame

-(NSMutableString *)description{
    self.reusedString = [NSMutableString stringWithString:@"["];
    for (Pin *pin in self.pins) {
        [self.reusedString appendString:pin.description];
        [self.reusedString appendString:@","];
    }
    if ([self.reusedString length]>1) {
        [self.reusedString deleteCharactersInRange:NSMakeRange([self.reusedString length]-1, 1)];
    }
    [self.reusedString appendString:@"]"];
    return self.reusedString;
}

/*-(instancetype)initWithPins:(NSArray *)pins{
    self = [super init];
    if (self) {
        NSMutableArray *newPins = [NSMutableArray array];
        for (Pin *currentPin in pins) {
            [newPins addObject:[currentPin copy]];
        }
        self.pins = [newPins copy];
    }
    return self;
}*/

@end
