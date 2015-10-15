//
//  Structure.h
//  SpaceNar
//
//  Created by Programming Account on 1/18/14.
//  Copyright (c) 2014 Baby Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Materials.h"
#import "Planet.h"

@interface Structure : NSObject

-(instancetype)initWithMaterials:(NSArray *)materials andEnergy:(NSInteger)energy andParentPlanet:(Planet *)parent;

@end
