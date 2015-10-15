//
//  Planet.m
//  SpaceNar
//
//  Created by Programming Account on 1/17/14.
//  Copyright (c) 2014 Baby Andrew. All rights reserved.
//

#import "Planet.h"

@interface Planet ()

@property(strong,nonatomic)NSMutableArray *structures; //of Structures
@property(strong,nonatomic)NSMutableArray *ships; //of Ships (subclass of Structures)
@property(nonatomic)NSInteger energy;
@property(strong,nonatomic)NSMutableArray *materials;

-(NSInteger)firstIndexOfMaterialWithType:(NSString *)type inArray:(NSArray *)array; //-1 if not found

@end

@implementation Planet

-(BOOL)removeEnergy:(NSInteger)energy{
    BOOL worked = YES;
    if (self.energy >= energy) {
        self.energy -= energy;
    } else {
        worked = NO;
    }
    return worked;
}
-(BOOL)removeMats:(NSArray *)mats{
    BOOL worked = YES;
    for (Materials *mat in mats) {
        NSInteger index = [self firstIndexOfMaterialWithType:mat.type inArray:self.materials];
        if (index >= 0) {
            Materials *matAtIndex = self.materials[index];
            NSInteger newAmount = matAtIndex.amount - mat.amount;
            [self.materials replaceObjectAtIndex:index withObject:[[Materials alloc]initWithAmount:newAmount andType:mat.type]];
        } else {
            worked = NO;
            break;
        }
    }
    return worked;
}
-(NSInteger)firstIndexOfMaterialWithType:(NSString *)type inArray:(NSArray *)array{
    NSInteger index = -1;
    for (Materials *currentMat in array) {
        if ([currentMat.type isEqualToString:type]) {
            index = [array indexOfObject:currentMat];
            break;
        }
    }
    return index;
}

@end
