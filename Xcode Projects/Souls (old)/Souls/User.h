//
//  User.h
//  Souls
//
//  Created by Programming Account on 4/24/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface User : NSObject

@property (nonatomic, strong) NSMutableArray *spellsKnown; //of MagicCards
@property (nonatomic, strong) NSMutableArray *souls; //of Souls;

@end
