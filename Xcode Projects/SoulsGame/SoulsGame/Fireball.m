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

@synthesize type = _type;
@synthesize name = _name;
@synthesize cost = _cost;
@synthesize desc = _desc;
@synthesize img = _img;
@synthesize flavorText = flavorText;

-(NSMutableArray*)affectMinion:(Minion *)minion{
    minion.health.amount -= self.damage;
    return nil;
}

-(instancetype)init{
    if (self = [super init]){
        self.type = Fire;
        self.name = @"Fireball";
        self.cost = 3;
        self.desc = @"Launches a ball of fire towards an enemy, dealing 3 points of fire damage";
        self.damage = 3;
        self.flavorText = @"A giant orb of fire flying towards your foe at a remarkable speed: simple but effective.";
        self.img = [UIImage imageNamed:@"Fireball.jpg"];
    }
    return self;
}

@end
