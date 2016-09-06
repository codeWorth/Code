//
//  Player.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Player.h"

@implementation Player

-(instancetype)init{
    if (self = [super init]){
        self.mana = 0;
        
        self.profileImg = [UIImage imageNamed:@"defaultProfile.png"];
        self.username = [NSString stringWithFormat:@"user%i",arc4random_uniform(100)];
    }
    return self;
}

-(void)update{
    
}

@end
