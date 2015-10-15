//
//  PlayerView.m
//  Stand-Off
//
//  Created by Programming Account on 8/24/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView ()

@property (nonatomic, strong) SKSpriteNode *node;

@end

@implementation PlayerView

-(instancetype)initWithImageNamed:(NSString *)image atPosition:(CGPoint)place withSize:(CGSize)size andLinkedPlayer:(Player *)player inScene:(SKScene *)scene{
    if (self = [super init]){
        self.node = [[SKSpriteNode alloc]initWithImageNamed:image];
        self.node.size = size;
        self.node.position = place;
        self.player = player;
        [scene addChild:self.node];
        return self;
    }
    return nil;
    
}

-(void)shoot{
    
}

@end
