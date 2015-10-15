//
//  LeaderItem.m
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "LeaderItem.h"

@implementation LeaderItem

-(id)initWithName:(NSString *)name score:(NSInteger)score description:(NSString *)desc andImage:(UIImage *)image{
    if (self = [super init]) {
        self.name = name;
        self.score = score;
        self.catPhoto = image;
        self.catDescription = desc;
    }
    return self;
}

+(id)itemWithName:(NSString *)name score:(NSInteger)score description:(NSString *)desc andImage:(UIImage *)image{
    LeaderItem *item = [[LeaderItem alloc]initWithName:name score:score description:desc andImage:image ];
    return item;
}

@end
