//
//  Game.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Game.h"

#import "Minion.h"

@implementation Game

-(instancetype)init{
    if (self = [super init]){
        self.time = 0;
        
        self.homePlayer = [[Player alloc]init];
        self.awayPlayer = [[Player alloc]init];
        
        self.homePlayer.minion2 = [[Minion alloc]initWithHealth:4 Speed:4 andShield:2];
        self.homePlayer.minion5 = [[Minion alloc]initWithHealth:5 Speed:2 andShield:5];
    }
    return self;
}

-(void)update{
    self.time++;
    
    [self.homePlayer update];
    [self.awayPlayer update];
}

@end
