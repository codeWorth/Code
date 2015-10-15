//
//  Planet.h
//  SpaceNar
//
//  Created by Programming Account on 1/17/14.
//  Copyright (c) 2014 Baby Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Structure.h"

@interface Planet : NSObject

-(BOOL)removeEnergy:(NSInteger)energy;
-(BOOL)removeMats:(NSArray *)mats;

@end
