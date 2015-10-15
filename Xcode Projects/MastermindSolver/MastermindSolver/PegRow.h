//
//  PegRow.h
//  MastermindSolver
//
//  Created by Programming Account on 4/19/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Peg.h"

@interface PegRow : NSObject

@property (nonatomic, strong) NSArray *pegs;

-(NSArray *)compareAgainstRow:(PegRow *)guess;

@end
