//
//  QuickHeal.m
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "QuickHeal.h"
#import "Minion.h"

@implementation QuickHeal

@synthesize type;
@synthesize name;
@synthesize cost;
@synthesize desc;
@synthesize img;
@synthesize flavorText;
@synthesize canTargetFriendlies;
@synthesize canTargetEnemies;

-(NSMutableArray*)affectMinion:(Minion *)minion{
    [minion addHealth:self.healing];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = Life;
        self.name = @"Quick Heal";
        self.cost = 3;
        self.desc = @"An efficent small heal that can be cast on any minion.";
        self.healing = 2;
        self.flavorText = @"I bring life...";
        self.img = [UIImage imageNamed:@"heal.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
    }
    return self;
}

@end
