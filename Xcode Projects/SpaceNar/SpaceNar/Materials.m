//
//  Materials.m
//  SpaceNar
//
//  Created by Programming Account on 1/17/14.
//  Copyright (c) 2014 Baby Andrew. All rights reserved.
//

#import "Materials.h"

@implementation Materials

-(instancetype)initWithAmount:(NSInteger)amount andType:(NSString *)type{
    self = [super init];
    if (self) {
        self.amount = amount;
        self.type = type;
    }
    return self;
}

@end
