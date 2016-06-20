//
//  Soul.h
//  Souls
//
//  Created by Programming Account on 4/1/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicType.h"
#import "SpellCard.h"

@interface Soul : NSObject <NSCoding>

@property (nonatomic, strong) NSString* type; //String that is this souls' type, not a magic type because it's amount doesn't matter.
@property (nonatomic, strong) NSArray* creatorSouls; //of Souls, the souls that created this one.

-(id)initWithCreatorSoul:(Soul *)soul1 andOtherSoul:(Soul *)soul2;


@end
