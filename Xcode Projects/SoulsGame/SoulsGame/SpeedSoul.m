//
//  SpeedSoul.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/28/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SpeedSoul.h"

@implementation SpeedSoul

@synthesize name = _name;
@synthesize img = _img;
@synthesize amount = _amount;
@synthesize desc = _desc;


-(instancetype)initWithSpeed:(NSInteger)speed{
    if (self = [super init]){
        self.amount = speed;
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
