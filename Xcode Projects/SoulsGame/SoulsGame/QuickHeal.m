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

@synthesize type = _type;
@synthesize name = _name;
@synthesize cost = _cost;
@synthesize desc = _desc;
@synthesize img = _img;
@synthesize flavorText = flavorText;

-(NSMutableArray*)affectMinion:(Minion *)minion{
    minion.health.amount += self.healing;
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = Life;
        self.name = @"Quick Heal";
        self.cost = 1;
        self.desc = @"An efficent small heal that can be cast on any minion.";
        self.healing = 2;
        self.flavorText = @"I bring life...";
        self.img = [UIImage imageNamed:@"heal.jpg"];
    }
    return self;
}

@end
