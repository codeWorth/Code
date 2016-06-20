//
//  Minion.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Spell.h"
#import "Minion.h"

#import "ResistSoul.h"
#import "BuffSoul.h"
#import "ActiveSoul.h"

#import "HealthSoul.h"
#import "SpeedSoul.h"
#import "ShieldSoul.h"
#import "TimedSoul.h"

#define DEFAULT_COOLDOWN 15;

@interface Minion : NSObject

@property (nonatomic, strong) HealthSoul* health;
@property (nonatomic, strong) SpeedSoul* speed;
@property (nonatomic, strong) ShieldSoul* shield;

@property (nonatomic) NSInteger cooldown;

-(instancetype)initWithHealth:(NSInteger)health Speed:(NSInteger)speed andShield:(NSInteger)shield;

-(BOOL)shouldAddResistSoul;
-(BOOL)shouldAddBuffSoul;
-(BOOL)shouldAddActiveSoul;

-(void)addResistSoul:(NSObject<ResistSoul>*)soul;
-(void)addBuffSoul:(NSObject<BuffSoul>*)soul;
-(void)addActiveSoul:(NSObject<ActiveSoul>*)soul;

-(void)castSpell:(NSObject<Spell>*)spell onTarget:(Minion*)target;
-(void)receiveSpell:(NSObject<Spell>*)spell;

-(void)update;

-(BOOL)canCastSpell:(NSObject<Spell>*)spell onTarget:(Minion*)target;

-(UIImage*)imgDesc;

@end
