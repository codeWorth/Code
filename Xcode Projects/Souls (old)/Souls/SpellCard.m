//
//  SpellCard.m
//  Souls
//
//  Created by Programming Account on 3/30/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "SpellCard.h"
#import "MagicType.h"
#import "Minion.h"
#import "Player.h"

@interface SpellCard ()

@property (nonatomic, copy) BOOL (^castFunc)(Minion *,id, NSInteger); //1st arg is me, 2nd args is enemies (either is a list of minions or is a single Minion *), and last arg is an optional tick. Make sure to call blockMagic and/or addBonusToMagic

@end

@implementation SpellCard

-(BOOL)castSelfOnMinion:(Minion *)enemy fromMinion:(Minion *)me withTick:(NSInteger)tick{
    if (me.energy >= self.requiredEnergy) { //if I have enough energy
        return self.castFunc(me,enemy,tick);
    }
    return NO;
}

-(BOOL)castSelfOnMinions:(NSArray *)enemies fromMinion:(Minion *)me withTick:(NSInteger)tick{
    if ((tick == 0 && me.energy >= self.requiredEnergy) || tick > 0) { //only check energy on first cast, when tick is 0. Works for spells with not tick, becuase default is 0.
        return self.castFunc(me,enemies,tick);
    }
    return NO;
}

-(id)initWithCastFunc:(BOOL (^)(Minion *, id, NSInteger))castFunc spellName:(NSString *)name magicType:(MagicType *)magic andWantedTargets:(NSInteger)targets{
    if (self = [super init]) {
        self.castFunc = castFunc;
        self.spellName = name;
        self.magicType = magic;
        self.wantedNumberOfTargets = targets;
    }
    return self;
}

-(BOOL)isEqual:(id)object{
    if ([object isKindOfClass:self.class]) {
        SpellCard *other = object;
        if ([self.spellName isEqualToString:other.spellName]) {
            return YES;
        }
    }
    return NO;
}

-(NSString *)spellName{
    if (!_spellName){
        _spellName = [[NSString alloc]init]; //lazy initaliztion
    }
    return _spellName;
}

-(MagicType *)magicType{
    if (!_magicType){
        _magicType = [[MagicType alloc]init]; //lazy initaliztion
    }
    return _magicType;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.spellName forKey:@"spellName"];
    [aCoder encodeDouble:self.requiredEnergy forKey:@"reqEnergy"];
    [aCoder encodeObject:self.magicType forKey:@"magicType"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        [aDecoder decodeObjectForKey:@"spellName"];
        [aDecoder decodeDoubleForKey:@"reqEnergy"];
        [aDecoder decodeObjectForKey:@"magicType"];
    }
    return self;
}

@end
