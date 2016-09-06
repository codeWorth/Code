//
//  SpellCard.h
//  Souls
//
//  Created by Programming Account on 3/30/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Minion;
@class MagicType;

@interface SpellCard : NSObject <NSCoding>

@property (strong, nonatomic) NSString *spellName; //Name of the spell.
@property (nonatomic) double requiredEnergy; //Energy required to cast.
@property (nonatomic, strong)MagicType *magicType; //The type of magic that this spell is.
@property (nonatomic) NSInteger wantedNumberOfTargets; //the number of targets that this spell wants, number selected is not neccisarily the number hit (aoe spells for example).
@property (nonatomic) BOOL hasTick; //if the spell should be paired with a tick

-(BOOL)castSelfOnMinion:(Minion *)enemy fromMinion:(Minion *)me withTick:(NSInteger)tick; //Pass zero to 'tick' if the function isn't affected by it.
-(BOOL)castSelfOnMinions:(NSArray *)enemies fromMinion:(Minion *)me withTick:(NSInteger)tick; //Pass zero to 'tick' if the function isn't affected by it.

-(id)initWithCastFunc:(BOOL (^)(Minion *, id, NSInteger))castFunc spellName:(NSString *)name magicType:(MagicType *)magic andWantedTargets:(NSInteger)targets; //suggested init, the cast func is supplied by you. There should be a list of spell cards in the User class, each with its own cast func.

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

@end
