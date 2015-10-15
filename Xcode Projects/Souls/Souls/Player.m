//
//  Player.m
//  Souls
//
//  Created by Programming Account on 3/30/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "Player.h"

@interface Player ()

-(void)spellsCast;
-(void)spellsUpdate;

@property (nonatomic, strong) NSMutableArray *spellsInLoop;

@end

@implementation Player

-(BOOL)removeSpell:(SpellCard *)spell{
    NSInteger index = [self.spells indexOfObject:spell];
    if (index == NSNotFound) {
        return NO;
    } else {
        [self.spells removeObjectAtIndex:index];
        return YES;
    }
}

-(void)minion:(NSInteger)indexOfMinion CastSpell:(SpellCard *)spell onMinions:(NSArray *)minions{
    Minion *minion = (Minion *)self.minions[indexOfMinion];
    [self.spells removeObject:spell];
    [minion addSpellToQue:spell withTargets:minions];
}

-(void)spellsUpdate{
    for (int i = 0; i < [self.spellsInLoop count]; i++) {
        BOOL dontCancel = [self.spellsInLoop[i] incrementTick];
        if (!dontCancel) {
            [self.spellsInLoop removeObjectAtIndex:i];
        }
    }
}

-(BOOL)spellIsAllowed:(SpellWithTickAndTarget *)spell{
    if (spell.spell != nil && [spell.minions count] > 0) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)scheduleSpellInLoop:(SpellWithTickAndTarget *)spell{
    if ([self spellIsAllowed:spell]) {
        [self.spellsInLoop addObject:spell];
        return YES;
    } else {
        return NO;
    }
}

-(void)spellsCast{
    for (Minion *minion in self.minions){
        [minion castSpells];
    }
}

-(NSInteger)createMinionWithSoul:(Soul *)soul1 andOtherSoul:(Soul *)soul2{
    [self.minions addObject:[[Soul alloc]initWithCreatorSoul:soul1 andOtherSoul:soul2]];
    return [self.minions count] - 1;
}

-(void)gameUpdate{
    [self spellsUpdate];
    [self spellsCast];
}

-(NSMutableArray *)spells{
    if (!_spells){
        _spells = [[NSMutableArray alloc]init];
    }
    return _spells;
}

-(NSMutableArray *)minions{
    if (!_minions){
        _minions = [[NSMutableArray alloc]init];
    }
    return _minions;
}

-(NSMutableArray *)spellsInLoop{
    if (!_spellsInLoop){
        _spellsInLoop = [[NSMutableArray alloc]init];
    }
    return _spellsInLoop;
}

//NSCoding protocol

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.spells forKey:@"spells"];
    [aCoder encodeObject:self.minions forKey:@"minions"];
    [aCoder encodeBool:self.isMyTurn forKey:@"isMyTurn"];
    [aCoder encodeObject:self.spellsInLoop forKey:@"spellsInLoop"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.spells = [aDecoder decodeObjectForKey:@"spells"];
        self.minions = [aDecoder decodeObjectForKey:@"minions"];
        self.isMyTurn = [aDecoder decodeBoolForKey:@"isMyTurn"];
        self.spellsInLoop = [aDecoder decodeObjectForKey:@"spellsInLoop"];
    }
    return self;
}

@end
