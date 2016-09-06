//
//  SpellWithTickAndTargetRename.m
//  Souls
//
//  Created by Programming Account on 7/10/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "SpellWithTickAndTarget.h"
#import "Player.h"

@interface SpellWithTickAndTarget ()

@property (nonatomic) NSInteger tick; //Number of ticks gone by so far, will be changed with incrementTick.
@property (nonatomic,strong) Minion *caster;
@property (nonatomic) BOOL inLoop;

@end


@implementation SpellWithTickAndTarget

-(void)startInLoopFromMinion:(Minion *)caster forPlayer:(Player *)owner{
    self.caster = caster; //sets the Caster, shouldn't be changed now.
    [owner scheduleSpellInLoop:self];
}

-(BOOL)castFromMinion:(Minion *)minionCaster{
    if (self.minions != nil && [self.minions count] > 0) { //checks that there are minions to cast on.
        BOOL shouldContinue;
        if ([self.minions count] == 1) { //if only one minion to cast on:
            shouldContinue = [self.spell castSelfOnMinion:self.minions[0] fromMinion:minionCaster withTick:self.tick]; //use SpellCard's castSelfOnMinion method,
        } else {
            shouldContinue = [self.spell castSelfOnMinions:self.minions fromMinion:minionCaster withTick:self.tick];//otherwise use castSelfOnMinions.
        }
        if (shouldContinue && !self.inLoop) {
            self.inLoop = YES;
            [self startInLoopFromMinion:minionCaster forPlayer:minionCaster.owner];
        } else {
            self.inLoop = NO;
        }
        return shouldContinue; //Except for on the first time, if the spell function in self.spell returned YES, this spell will not be removed from the run loop, otherwise it will be. On the first time, if this returns no, the minion who called this will interpert it as an error occuring.
    } else {
        return NO; //If something went wrong, remove it form the run loop.
    }
}

-(BOOL)incrementTick{ //casts the spell then increments the tick
    BOOL shouldContinue = [self castFromMinion:self.caster];
    self.tick++;
    return shouldContinue;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.spell forKey:@"spell"];
    [aCoder encodeInteger:self.tick forKey:@"tick"];
    [aCoder encodeObject:self.minions forKey:@"minions"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.spell = [aDecoder decodeObjectForKey:@"spell"];
        self.tick = [aDecoder decodeIntegerForKey:@"tick"];
        self.minions = [aDecoder decodeObjectForKey:@"minions"];
    }
    return self;
}

-(instancetype)initWithSpell:(SpellCard *)spell onMinions:(NSArray *)minions{
    if (self = [super init]) {
        self.spell = spell;
        self.minions = [minions mutableCopy]; //Get my own mutable copy of the minions.
        self.tick = 0;
        self.inLoop = NO;
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        self.tick = 0;
        self.inLoop = NO;
    }
    return self;
}

@end
