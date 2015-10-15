//
//  Pin.m
//  TowersOfHanoiFix
//
//  Created by Programming Account on 1/5/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "Pin.h"

@interface Pin()

-(Ring *)lastRing;
@property(nonatomic,strong)NSMutableString *reusedString;

@end

@implementation Pin

-(Ring *)lastRing{
    Ring *lastRing = [self.rings lastObject];
    return lastRing;
}

-(NSInteger)ringsAboveRingNumber:(NSInteger)ringNumber{
    NSInteger ringsAbove = 0;
    for (int i = ringNumber+1; i<[self.rings count]; i++) {
        ringsAbove++;
    }
    return ringsAbove;
}

-(Ring *)removeAndReturnLastRing{
    Ring *lastRing = [self lastRing];
    [self.rings removeLastObject];
    return lastRing;
}

-(NSString *)placeRingOnSelf:(Ring *)ring{
    NSString *error = @"";
    if (!ring) {
        error = @"You must give me something!";
    } else if (![ring isMemberOfClass:[Ring class]]){
        error = @"You must give a ring!";
    } else if ([self lastRing]){
        if (ring.size > [self lastRing].size) {
            error = @"Your ring must me smaller than ring it is placed upon!";
        } else {
            [self.rings addObject:ring];
        }
    } else {
        [self.rings addObject:ring];
    }

    return error;
}

-(instancetype)initWithRings:(NSArray *)rings{
    self = [super init];
    if (self) {
        self.rings = [rings mutableCopy];
    }
    return self;
}

-(NSMutableString *)description{
    self.reusedString = [NSMutableString stringWithString:@"["];
    for (Ring *ring in self.rings) {
        [self.reusedString appendString:ring.description];
        [self.reusedString appendString:@","];
    }
    if ([self.reusedString length]>1){
        [self.reusedString deleteCharactersInRange:NSMakeRange([self.reusedString length]-1, 1)];
    }
    [self.reusedString appendString:@"]"];
    return self.reusedString;
}

/*-(Pin *)copy{
    NSMutableArray *copyRings = [NSMutableArray array];
    
    for (Ring *currentRing in self.rings) {
        [copyRings addObject:[[Ring alloc]initWithSize:currentRing.size]];
    }
    
    Pin *copyPin = [[Pin alloc]initWithRings:[copyRings copy]];
    return copyPin;
}*/

@end

