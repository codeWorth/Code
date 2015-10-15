//
//  Ring.m
//  TowersOfHanoiFix
//
//  Created by Programming Account on 1/5/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "Ring.h"

@implementation Ring

-(instancetype)initWithSize:(NSInteger)size{
    self = [super init];
    if (self) {
        self.size = size;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%i",self.size];
}

@end
