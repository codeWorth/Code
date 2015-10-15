//
//  Minion.m
//  Souls
//
//  Created by Programming Account on 3/30/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "Minion.h"
#import "Player.h"

@interface Minion ()

@property (nonatomic, strong) NSMutableArray *selectedSpells; //of SpellAndTargets;

@end

@implementation Minion

-(id)initWithSouls:(NSArray *)souls andOwner:(Player *)owner{
    if (self = [super init]) {
        self.souls = souls;
        self.maxHealth = 1000; //these values may change later
        self.health = self.maxHealth;
        self.maxNumOfSpellsPerRound = 2;
        self.energy = 100;
        self.owner = owner;
    }
    return self;
}

-(BOOL)castSpells{
    BOOL didSucceed = YES;
    for (SpellAndTarget *spell in self.selectedSpells) { //goes through the selected spells and casts them on their targets. For the SpellWithTickAndTarget, casting it sets up the tick
        BOOL error = [spell castFromMinion:self];
        if (!error) {
            didSucceed = NO;
        }
    }
    return didSucceed;
}

-(double)castingEffectOfSelfOn:(MagicType *)magic{
    double amount = magic.amount;
    double mult = [magic interactWithMinion:self]; //Figures out what to multiply the magic amount by then multiplies it.
    amount = amount * mult;
    return amount;
}

-(double)receivingEffectOfSelfOn:(MagicType *)magic{
    double amount = magic.amount;
    double mult = [magic blockMinion:self]; //Figures out what to multiply the magic amount by then multiplies it.
    amount = amount * mult;
    return amount;
}

-(NSInteger)addSpellToQue:(SpellCard *)spell withTargets:(NSArray *)minions{
    if (spell.hasTick) { //if the spell should be over time
        [self.selectedSpells addObject:[[SpellWithTickAndTarget alloc]initWithSpell:spell onMinions:minions]]; //uses the tick spell and target Class
    } else { //otherwise,
        [self.selectedSpells addObject:[[SpellAndTarget alloc]initWithSpell:spell onMinions:minions]]; //uses the basic spell and target class
    }
    [self.owner removeSpell:spell];
    return [self.selectedSpells count] - 1; //because the spell was added to the end, returns the last index in the array.
}

-(BOOL)deselectCard:(NSInteger)index{
    if (index >= 0 && index < [self.selectedSpells count]) {
        [self.selectedSpells removeObjectAtIndex:index];
        return YES;
    }
    return NO; //if there was a problem when removing the card.
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.maxHealth forKey:@"maxHealth"];
    [aCoder encodeInteger:self.health forKey:@"health"];
    [aCoder encodeDouble:self.energy forKey:@"energy"];
    [aCoder encodeObject:self.souls forKey:@"souls"];
    [aCoder encodeObject:self.owner forKey:@"owner"];
    [aCoder encodeInteger:self.maxNumOfSpellsPerRound forKey:@"maxNumOfSpellsPerRound"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.maxHealth = [aDecoder decodeIntegerForKey:@"maxHealth"];
        self.health = [aDecoder decodeIntegerForKey:@"health"];
        self.energy = [aDecoder decodeDoubleForKey:@"energy"];
        self.souls = [aDecoder decodeObjectForKey:@"souls"];
        self.owner = [aDecoder decodeObjectForKey:@"owner"];
        self.maxNumOfSpellsPerRound = [aDecoder decodeIntegerForKey:@"maxNumOfSpellsPerRound"];
    }
    return self;
}

@end
