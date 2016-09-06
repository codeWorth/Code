//
//  SpaceshipScene.m
//  Souls
//
//  Created by Programming Account on 7/8/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "SpaceshipScene.h"

@interface SpaceshipScene ()
@property BOOL contentCreated;
@end

@implementation SpaceshipScene

- (void)didMoveToView:(SKView *)view{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];
    
    SKSpriteNode *floor = [[SKSpriteNode alloc]initWithColor:self.backgroundColor size:CGSizeMake(self.frame.size.width, 10)];
    floor.position = CGPointMake(CGRectGetMidX(self.frame), 0);
    [self addChild:floor];
    floor.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
    floor.physicsBody.dynamic = NO;
}

-(SKSpriteNode *)newSpaceship{
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(64,32)];
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic = NO;
    
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-28.0, 6.0);
    [hull addChild:light1];
    
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(28.0, 6.0);
    [hull addChild:light2];
    
    SKSpriteNode *engine1 = [self newEngine];
    engine1.position = CGPointMake(24, -20);
    [hull addChild:engine1];
    
    SKSpriteNode *engine2 = [self newEngine];
    engine2.position = CGPointMake(-24, -20);
    [hull addChild:engine2];
    
    SKAction *acAndDeDown = [self accelAndDecelOverSeconds:1.5 inUnitsOfTime:0.1 Up:NO];
    SKAction *acAndDeUp = [self accelAndDecelOverSeconds:1.5 inUnitsOfTime:0.1 Up:YES];
    
    SKAction *hover = [SKAction sequence:@[acAndDeDown,acAndDeUp]];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    return hull;
}

-(SKAction *)accelAndDecelOverSeconds:(double)seconds inUnitsOfTime:(double)units Up:(BOOL)up{
    double mult;
    if (up) {
        mult = 1;
    } else {
        mult = -1;
    }
    double speed = 0;
    double scaleFactor = 0.075;
    NSMutableArray *sequence = [NSMutableArray array];
    for (int i = 2; i<seconds/units/2; i++) {
        speed = mult*i*i*i*scaleFactor;
        [sequence addObject:[SKAction moveByX:0.0 y:speed duration:units]];
    }
    for (int i = seconds/units/2; i>=2; i--) {
        speed = mult*i*i*i*scaleFactor;
        [sequence addObject:[SKAction moveByX:0.0 y:speed duration:units]];
    }
    return [SKAction sequence:sequence];
}

- (SKSpriteNode *)newLight
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(8,8)];
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction: blinkForever];
    
    return light;
}

-(SKSpriteNode *)newEngine{
    SKSpriteNode *engine = [[SKSpriteNode alloc]initWithColor:[SKColor orangeColor] size:CGSizeMake(8, 16)];
    
    SKAction *pulse = [SKAction sequence:@[
                                           [SKAction colorizeWithColor:[SKColor yellowColor] colorBlendFactor:1 duration:0.1],
                                           [SKAction colorizeWithColor:[SKColor orangeColor] colorBlendFactor:1 duration:0.1]]];
    SKAction *pulseForever = [SKAction repeatActionForever:pulse];
    [engine runAction:pulseForever];
    
    return engine;
}

static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

- (void)addRock{
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(8, 8)];
    rock.position = CGPointMake(skRand(0, self.size.width), self.size.height-50);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:rock];
}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)even{
    [self runAction:[SKAction performSelector:@selector(addRock) onTarget:self]];
}

@end
