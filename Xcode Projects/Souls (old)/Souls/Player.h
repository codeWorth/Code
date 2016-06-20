//
//  Player.h
//  Souls
//
//  Created by Programming Account on 3/30/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Minion.h"
#import "SpellCard.h"
#import "SpellWithTickAndTarget.h"

@interface Player : NSObject <NSCoding>

@property (nonatomic, strong) NSMutableArray *spells; //of SpellCards. Currently in deck.
@property (nonatomic, strong) NSMutableArray *minions; //of Minions.
@property (nonatomic) BOOL isMyTurn;

-(void)gameUpdate;

-(NSInteger)createMinionWithSoul:(Soul *)soul1 andOtherSoul:(Soul *)soul2; //creates a new Minion for this player.
-(BOOL)scheduleSpellInLoop:(SpellWithTickAndTarget *)spell; //adds a tick spell to the loop.

-(BOOL)removeSpell:(SpellCard *)spell; //removes the pased spell from the deck and returns if the spell was found.

-(void)minion:(NSInteger)indexOfMinion CastSpell:(SpellCard *)spell onMinions:(NSArray *)minions; //tells a minion to cast a spell then removes the spell.

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

@end
