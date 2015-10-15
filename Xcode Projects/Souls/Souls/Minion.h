//
//  Minion.h
//  Souls
//
//  Created by Programming Account on 3/30/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soul.h"
@class Player;
#import "SpellAndTarget.h"

@interface Minion : NSObject <NSCoding>

@property (nonatomic) NSInteger maxHealth; //starting and maximum health.
@property (nonatomic) NSInteger health; //current health.
@property (nonatomic) double energy; //current energy.
@property (nonatomic, strong) NSArray* souls; //souls that make this minion up.
@property (nonatomic, strong) Player *owner; //the player that made this minion.
@property (nonatomic) NSInteger maxNumOfSpellsPerRound; //the how spells can be cast each round, probably one.

-(BOOL)castSpells; //casts all spells in selected spells. 
-(double)castingEffectOfSelfOn:(MagicType *)magic; //returns the amount of the magic if it had been "cast" from this minion
-(double)receivingEffectOfSelfOn:(MagicType *)magic; //returns the amount of magic if it had been "cast" on this minion
-(NSInteger)addSpellToQue:(SpellCard *)spell withTargets:(NSArray *)minions; //adds a spell to the selectedSpells array in the form of a SpellAndTarget or a SpellWithTickAndTarget. Returns the index of the added spell.
-(BOOL)deselectCard:(NSInteger)index; //deselects the card at the given index.

-(id)initWithSouls:(NSArray *)souls andOwner:(Player *)owner; //suggested init function.

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

@end
