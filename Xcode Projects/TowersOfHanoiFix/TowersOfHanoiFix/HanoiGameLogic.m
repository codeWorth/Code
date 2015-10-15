//
//  HanoiGame.m
//  TowersOfHanoiFix
//
//  Created by Programming Account on 1/5/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "HanoiGameLogic.h"

@interface HanoiGameLogic()

-(NSInteger)otherPinOfPinNumber:(NSInteger)pin1 andOtherPinNumber:(NSInteger)pin2;
-(void)moveFromPin:(NSInteger)startPinNumber toOtherPin:(NSInteger)targetPinNumber;
-(void)solveMoveRing:(NSInteger)ringNumber onPin:(NSInteger)pinNumber toPin:(NSInteger)targetPinNumber;

@property(nonatomic,strong)NSMutableArray *towerMoves;
@property(nonatomic,strong)NSArray *pins;
@property(nonatomic,strong)NSMutableString *reusedContents;

@end

@implementation HanoiGameLogic

-(NSInteger)otherPinOfPinNumber:(NSInteger)pin1 andOtherPinNumber:(NSInteger)pin2{
    NSInteger otherPinNumber = 0;
    if (!(pin1 == pin2)) {
        otherPinNumber = -1 * (pin1-1 + pin2-1) + 1;  //discuss with Josh (said mom)?
    }
    return otherPinNumber;
}

#define FILENAME @"/Users/ProgrammingAccount/Desktop/plainEmpty.txt"

-(void)moveFromPin:(NSInteger)startPinNumber toOtherPin:(NSInteger)targetPinNumber{
    Pin *startPin = self.pins[startPinNumber];
    Pin *targetPin = self.pins[targetPinNumber];
    Ring *topRingOfStartPin = [startPin removeAndReturnLastRing];
    NSString *error = [targetPin placeRingOnSelf:topRingOfStartPin];
    if ([error length] > 0) {
        NSLog(@"%@", error);
    }
    self.reusedContents = [NSMutableString stringWithContentsOfFile:FILENAME encoding:NSUTF8StringEncoding error:nil];
    [self.reusedContents appendString:self.description];
    [self.reusedContents appendString:@"\n"];
    [self.reusedContents writeToFile:FILENAME atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //[self.towerMoves addObject:self.description];
}

-(NSArray *)towerSolve{
    self.towerMoves = [NSMutableArray array];
    //[self.towerMoves addObject:self.description];
    [[self.description stringByAppendingString:@"\n"] writeToFile:FILENAME atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [self solveMoveRing:0 onPin:0 toPin:2];
    
    return [self.towerMoves copy];
}

-(void)solveMoveRing:(NSInteger)ringNumber onPin:(NSInteger)pinNumber toPin:(NSInteger)targetPinNumber{
    Pin *startPin = self.pins[pinNumber];
    if ([startPin ringsAboveRingNumber:ringNumber] == 0) {
        [self moveFromPin:pinNumber toOtherPin:targetPinNumber];
    } else {
        NSInteger otherPinNumber = [self otherPinOfPinNumber:pinNumber andOtherPinNumber:targetPinNumber];
        Pin *otherPin = self.pins[otherPinNumber];
        NSInteger numOfPinsAbove = [startPin ringsAboveRingNumber:ringNumber];
        [self solveMoveRing:ringNumber+1 onPin:pinNumber toPin:otherPinNumber];
        [self moveFromPin:pinNumber toOtherPin:targetPinNumber];
        [self solveMoveRing:[otherPin.rings count]-numOfPinsAbove onPin:otherPinNumber toPin:targetPinNumber];
    }
}

-(instancetype)initWithRings:(NSInteger)numOfRings{
    self = [super init];
    if (self) {
        NSMutableArray *ringsArray = [NSMutableArray array];
        for (int i = 0; i <  numOfRings; i++) {
            [ringsArray insertObject:[[Ring alloc]initWithSize:i] atIndex:0];
        }
        self.pins = @[[[Pin alloc]initWithRings:[ringsArray copy]],
                      [[Pin alloc]initWithRings:@[]],
                      [[Pin alloc]initWithRings:@[]]];
    }
    return self;
}

@end

