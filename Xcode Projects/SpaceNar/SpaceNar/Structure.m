//
//  Structure.m
//  SpaceNar
//
//  Created by Programming Account on 1/18/14.
//  Copyright (c) 2014 Baby Andrew. All rights reserved.
//

#import "Structure.h"

@interface Structure ()

+(NSArray *)reqMatsToBuild;
+(NSInteger)reqEnergyToBuild;

@end

@implementation Structure

+(NSArray *)reqMatsToBuild{
    static NSArray *matsReq = nil;
    
    if (matsReq == nil) {
        matsReq = @[];
    }
    
    return matsReq; //list of Materials
}
+(NSInteger)reqEnergyToBuild{
    return 0;
}

-(instancetype)initWithMaterials:(NSArray *)materials andEnergy:(NSInteger)energy andParentPlanet:(Planet *)parent{
    BOOL hasMats = YES;
    BOOL hasEnergy = NO;
    for (Materials *reqMat in [[self class] reqMatsToBuild]) {
        if (![materials containsObject:reqMat]) {
            hasMats = NO;
        }
    }
    if (energy >= [[self class] reqEnergyToBuild]) {
        hasEnergy = YES;
    }
    if (hasEnergy && hasMats) {
        self = [super init];
        if (self) {
            [parent removeEnergy:[[self class]reqEnergyToBuild]];
            [parent removeMats:[[self class]reqMatsToBuild]];
            NSLog(@"Please perform custom initialization");
        }
        return self;
    } else {
        return nil;
    }
}

@end
