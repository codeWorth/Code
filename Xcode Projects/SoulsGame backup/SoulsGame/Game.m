//
//  Game.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Game.h"
#import "FireResist.h"
#import "Minion.h"

@implementation Game

static Game* gameInstance = nil;

-(instancetype)init{
    if (self = [super init]){
        self.time = 0;
        
        self.homePlayer = [[Player alloc]init];
        self.awayPlayer = [[Player alloc]init];
        
        self.homeKnownResist = [[NSArray alloc]initWithObjects:[[FireResist alloc]init], nil];
        self.homeKnownBuff = [[NSArray alloc]init];
        self.homeKnownSpec = [[NSArray alloc]init];
        
        self.homePlayer.minion5 = [[Minion alloc]initWithHealth:5 Speed:2 shield:5 andOwner:self.homePlayer];
        self.homePlayer.minion2 = [[Minion alloc]initWithHealth:4 Speed:4 shield:4 andOwner:self.homePlayer];
        
        self.awayPlayer.minion3 = [[Minion alloc]initWithHealth:10 Speed:1 shield:1 andOwner:self.awayPlayer];
        
        //REMOVE THIS EVENTUALLY
        self.canAttack = YES;
    }
    return self;
}

-(void)update{
    [self.homePlayer update];
    [self.awayPlayer update];
    
    if ([self.homePlayer minCooldown] <= 0){
        if ([self.homePlayer minCooldown] < [self.awayPlayer minCooldown]){
            self.canAttack = YES;
        }
    }
    if ([self.awayPlayer minCooldown] <= 0){
        if ([self.awayPlayer minCooldown] < [self.homePlayer minCooldown]){
            // FIX THIS EVENTUALLY
            //self.canAttack = NO;
            
            Player* temp = self.homePlayer;
            self.homePlayer = self.awayPlayer;
            self.awayPlayer = temp;
        }
    }
}

-(void)homeEndTurn{
    self.time++;
    [self.homePlayer nextTurn];
    
    // FIX THIS EVENTUALLY
    //self.canAttack = NO;
    
    Player* temp = self.homePlayer;
    self.homePlayer = self.awayPlayer;
    self.awayPlayer = temp;
}

-(void)awayEndTurn{
    self.time++;
    [self.awayPlayer nextTurn];
    
    self.canAttack = YES;
}

+(Game*)instance {
    @synchronized(self) {
        if (gameInstance == nil) {
            gameInstance = [[self alloc] init];
        }
    }
    
    return gameInstance;
}

@end
