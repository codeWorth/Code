//
//  PlayerView.h
//  Stand-Off
//
//  Created by Programming Account on 8/24/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"

@interface PlayerView : SKSpriteNode

@property (nonatomic, strong) Player *player;

-(void)dodgeBulletOverSeconds:(int)seconds;
-(void)shoot;

@end
