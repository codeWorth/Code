//
//  Soul.m
//  Souls
//
//  Created by Programming Account on 4/1/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "Soul.h"

@interface Soul ()

@end

@implementation Soul

-(id)initWithCreatorSoul:(Soul *)soul1 andOtherSoul:(Soul *)soul2{
    if (self = [super init]) {
        self.creatorSouls = @[soul1, soul2];
        if (![[MagicType typeFromType:soul1.type andOtherType:soul2.type]  isEqual:@"NO"]) {
            self.type = [MagicType typeFromType:soul1.type andOtherType:soul2.type];
        } else {
            return NO;
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.creatorSouls forKey:@"creatorSouls"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        [aDecoder decodeObjectForKey:@"type"];
        [aDecoder decodeObjectForKey:@"creatorSouls"];
    }
    return self;
}

@end
