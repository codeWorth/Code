//
//  standoffMyScene.m
//  Stand-Off
//
//  Created by Programming Account on 8/19/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "standoffMyScene.h"

@implementation standoffMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKSpriteNode *backgroundImage = [[SKSpriteNode alloc]initWithImageNamed:@"wild_west_background.jpg"];
        backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        backgroundImage.size = self.frame.size;
        
        [self addChild:backgroundImage];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
