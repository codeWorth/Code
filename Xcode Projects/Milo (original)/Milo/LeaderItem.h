//
//  LeaderItem.h
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaderItem : NSObject

@property (nonatomic, strong) UIImage *catPhoto;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger score;
@property (nonatomic, strong) NSString *catDescription;

+(id)itemWithName:(NSString *)name score:(NSInteger)score description:(NSString *)desc andImage:(UIImage *)image;

@end
