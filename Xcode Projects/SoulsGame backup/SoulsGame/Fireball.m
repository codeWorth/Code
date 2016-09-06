//
//  FireSpell.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Fireball.h"
#import "Minion.h"

@implementation Fireball

@synthesize type;
@synthesize name;
@synthesize cost;
@synthesize desc;
@synthesize img;
@synthesize flavorText;
@synthesize canTargetFriendlies;
@synthesize canTargetEnemies;

-(NSMutableArray*)affectMinion:(Minion *)minion{
    [minion removeHealth:self.damage];
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = Fire;
        self.name = @"Fireball";
        self.cost = 6;
        self.desc = @"Launches a ball of fire towards an enemy, dealing 3 points of fire damage";
        self.damage = 3;
        self.flavorText = @"A giant orb of fire flying towards your foe at a remarkable speed: simple but effective.";
        self.img = [UIImage imageNamed:@"Fireball.jpg"];
        
        self.canTargetEnemies = YES;
        self.canTargetFriendlies = YES;
    }
    return self;
}

@end
