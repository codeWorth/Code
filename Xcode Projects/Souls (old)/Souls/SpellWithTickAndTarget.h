//
//  SpellWithTickAndTargetRename.h
//  Souls
//
//  Created by Programming Account on 7/10/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "SpellAndTarget.h"
#import "SpellCard.h"

@class SpellCard;
@class SpellAndTarget;
@class Player;

//Pairs a SpellCard, targets (which are minions), and a tick, which is how many game ticks have gone by since the spell was cast.

@interface SpellWithTickAndTarget : SpellAndTarget <NSCoding>

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

-(BOOL)incrementTick; //increment the tick by one, which also calls the cast function of the spell. Returns wether the function should stay in the increment loop.
-(void)startInLoopFromMinion:(Minion *)caster forPlayer:(Player *)owner; //Tells the player to schedule this spell from the specified caster (a minion) in the loop that is triggered when gameUpdate is called (see Player *).

@end
