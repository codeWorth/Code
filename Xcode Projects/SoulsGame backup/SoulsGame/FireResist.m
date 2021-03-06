//
//  FireResist.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "FireResist.h"

@implementation FireResist

@synthesize name = _name;
@synthesize resistAmount = _resistAmount;
@synthesize img = _img;
@synthesize type = _type;
@synthesize desc = _desc;

-(instancetype)init{
    if (self = [super init]){
        self.resistAmount = 1;
        self.name = @"Fire Resistance";
        self.type = Fire;
        self.desc = @"A basic resistance soul. Will block a small portion of any incoming fire attack";
        self.img = [UIImage imageNamed:@"fire.jpg"];
    }
    return self;
}

-(void)applyMinorBuff{
    self.resistAmount += MINOR_BUFF_AMOUNT;
}

-(void)applyMajorBuff{
    self.resistAmount += MAJOR_BUFF_AMOUNT;
}

-(void)resistSpell:(NSObject<Spell>*)spell{
    if (spell.type == Fire){
        Fireball* fireSpell = (Fireball*)spell;
        fireSpell.damage -= self.resistAmount;
    }
}

-(NSInteger)cost{
    return RESIST_COST;
}

@end
