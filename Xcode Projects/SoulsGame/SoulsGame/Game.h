//
//  Game.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@class Minion;

@interface Game : NSObject

@property (nonatomic) NSInteger time;

@property (nonatomic, strong) Player* homePlayer;
@property (nonatomic, strong) Player* awayPlayer;

-(void)update;

@end
