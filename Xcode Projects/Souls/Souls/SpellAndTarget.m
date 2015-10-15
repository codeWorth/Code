//
//  SpellAndTarget.m
//  Souls
//
//  Created by Programming Account on 4/14/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "SpellAndTarget.h"

#import "SpellCard.h"
#import "Minion.h"

@implementation SpellAndTarget

-(BOOL)castFromMinion:(Minion *)minionCaster{
    if (self.minions != nil && [self.minions count] > 0) { //checks that there are minions to cast on.
        if ([self.minions count] == 1) { //if only one minion to cast on:
            [self.spell castSelfOnMinion:self.minions[0] fromMinion:minionCaster withTick:0]; //use SpellCard's castSelfOnMinion method,
        } else {
            [self.spell castSelfOnMinions:self.minions fromMinion:minionCaster withTick:0];//otherwise use castSelfOnMinions.
        }
        return YES;
    } else {
        return NO;
    }
}

-(id)initWithSpell:(SpellCard *)spell onMinions:(NSArray *)minions{ //usually use this init.
    if (self = [super init]) {
        self.spell = spell;
        self.minions = [minions mutableCopy]; //Get my own mutable copy of the minions.
    }
    return self;
}

-(BOOL)isEqual:(id)object{ //check if this is equal to another, ignores .minions (the targets).
    if ([object isKindOfClass:self.class]) {
        SpellAndTarget *otherSPPair = object;
        if ([self.spell isEqual:otherSPPair.spell]) {
            return YES;
        }
    }
    return NO;
}

-(void)deselectMinions{
    [self.minions removeAllObjects];
}

-(SpellCard *)spell{
    if (!_spell){
        _spell = [[SpellCard alloc]init]; //lazy initalization
    }
    return _spell;
}

-(NSMutableArray *)minions{
    if (!_minions){
        _minions = [[NSMutableArray alloc]init]; //lazy initalization
    }
    return _minions;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.spell forKey:@"spell"];
    [aCoder encodeObject:self.minions forKey:@"minions"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.spell = [aDecoder decodeObjectForKey:@"spell"];
        self.minions = [aDecoder decodeObjectForKey:@"minions"];
    }
    return self;
}

@end
