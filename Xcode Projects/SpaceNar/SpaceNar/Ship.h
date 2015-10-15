//
//  Ship.h
//  SpaceNar
//
//  Created by Programming Account on 1/18/14.
//  Copyright (c) 2014 Baby Andrew. All rights reserved.
//

#import "Structure.h"

@interface Ship : Structure

@property(nonatomic)NSInteger health;
@property(nonatomic)NSInteger fireRate;
@property(nonatomic)NSInteger firePower;

-(NSInteger)fireAtTarget:(Structure *)target;

@end
