//
//  SpellAndTarget.h
//  Souls
//
//  Created by Programming Account on 4/14/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SpellCard;
@class Minion;

//Pairs a SpellCard and a Target, which is a minion or minions.

@interface SpellAndTarget : NSObject <NSCoding>

@property (nonatomic, strong) SpellCard *spell;
@property (nonatomic, strong) NSMutableArray *minions; //of Minions. You may add minions to this.

-(BOOL)castFromMinion:(Minion *)minionCaster; //casts the Spell the passed in minion.
-(id)initWithSpell:(SpellCard *)spell onMinions:(NSArray *)minions; //an Array of minions that the spell is cast on. Can contain only one minion, or more than one. Depends on the SpellCard.
-(void)deselectMinions; //Deselect all minions.

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

@end
