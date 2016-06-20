//
//  Minion.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Minion.h"
#import "Soul.h"

@interface Minion ()

@property (nonatomic, strong) NSMutableArray* resistSouls;
@property (nonatomic, strong) NSMutableArray* buffSouls;
@property (nonatomic, strong) NSMutableArray* activeSouls;

@property (nonatomic, strong) NSMutableArray* effects;
-(void)applyEffects:(NSObject<Spell>*)spell;

@property (nonatomic) NSInteger affectedCooldown;

@end

@implementation Minion

+(double)BASE_STATS_TOTAL{
    return 12;
}

-(instancetype)initWithHealth:(NSInteger)health Speed:(NSInteger)speed andShield:(NSInteger)shield{
    if ((self = [super init]) && speed+health+shield == [Minion BASE_STATS_TOTAL]){
        self.shield = [[ShieldSoul alloc]initWithShield:shield];
        self.health = [[HealthSoul alloc]initWithHealth:health];
        self.speed = [[SpeedSoul alloc]initWithSpeed:speed];
        
        self.resistSouls = [[NSMutableArray alloc]initWithCapacity:3];
        self.buffSouls = [[NSMutableArray alloc]initWithCapacity:4];
        self.activeSouls = [[NSMutableArray alloc]initWithCapacity:3];
        
        self.affectedCooldown = DEFAULT_COOLDOWN;
        self.affectedCooldown -= self.speed.amount;
        
        self.cooldown = self.affectedCooldown;
    }
    return self;
}

-(BOOL)shouldAddResistSoul{
    return self.resistSouls.count < 3;
}

-(BOOL)shouldAddBuffSoul{
    return self.buffSouls.count < 4;
}

-(BOOL)shouldAddActiveSoul{
    return self.activeSouls.count < 3;
}

-(void)addResistSoul:(NSObject<ResistSoul>*)soul{
    [self.resistSouls addObject:soul];
}

-(void)addBuffSoul:(NSObject<BuffSoul>*)soul{
    [self.buffSouls addObject:soul];
}

-(void)addActiveSoul:(NSObject<ActiveSoul>*)soul{
    [self.activeSouls addObject:soul];
}

-(NSArray*)getResistSouls{
    return [self.resistSouls copy];
}

-(NSArray*)getBuffSouls{
    return [self.buffSouls copy];
}

-(NSArray*)getActiveSouls{
    return [self.activeSouls copy];
}

-(void)castSpell:(NSObject<Spell> *)spell onTarget:(Minion *)target{
    self.cooldown = self.affectedCooldown;
    
    for (NSObject<BuffSoul>* buff in self.buffSouls) {
        [buff buffSpell:spell];
    }
    
    [target receiveSpell:spell];	
}

-(void)receiveSpell:(NSObject<Spell> *)spell{
    for (NSObject<ResistSoul>* resistance in self.resistSouls) {
        [resistance resistSpell:spell];
    }
    
    
    [self.effects addObjectsFromArray:[spell affectMinion:self]];
}

-(void)update{
    if (self.cooldown > 0){
        self.cooldown--;
    }
    
    for (TimedSoul *soul in self.effects) {
        [soul update];
        if ([soul shouldRemove]){
            [self.effects removeObject:soul];
        }
    }
}

-(BOOL)canCastSpell:(NSObject<Spell>*)spell onTarget:(Minion *)target{
    if (self.cooldown == 0){
        return true;
    }
    return false;
}

-(void)applyEffects:(id)spell{
    for (TimedSoul* soul in self.effects) {
        if ([[soul getSoul] conformsToProtocol:@protocol(BuffSoul)]){
            NSObject<BuffSoul>* buffSoul = (NSObject<BuffSoul>*)[soul getSoul];
            [buffSoul buffSpell:spell];
        } else if ([[soul getSoul] conformsToProtocol:@protocol(ResistSoul)]){
            NSObject<ResistSoul>* resistSoul = (NSObject<ResistSoul>*)[soul getSoul];
            [resistSoul resistSpell:spell];
        }
    }
}

-(UIImage*)imgDesc{
    if (self.resistSouls.count == 0){
        UIImage* img = [UIImage imageNamed:@"crystal.jpg"];
        return img;
    } else {
        return nil;
    }
}

@end
