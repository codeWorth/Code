//
//  HealthSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "HealthSoul.h"

@implementation HealthSoul

@synthesize name = _name;
@synthesize img = _img;
@synthesize amount = _amount;
@synthesize desc = _desc;

-(instancetype)initWithHealth:(NSInteger)health{
    if (self = [super init]){
        self.amount = health;
    }
    return self;
}

-(void)affectSpell:(NSObject<Spell> *)spell{
    
}

-(void)applyMinorBuff{
    self.amount += MINOR_BUFF_AMOUNT;
}

-(void)applyMajorBuff{
    self.amount += MAJOR_BUFF_AMOUNT;
}

@end
