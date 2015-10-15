//
//  PegRow.m
//  MastermindSolver
//
//  Created by Programming Account on 4/19/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "PegRow.h"

@implementation PegRow

-(NSArray *)compareAgainstRow:(PegRow *)guess{
    NSMutableArray *pegsLeft = [self.pegs mutableCopy];
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (Peg *peg in guess.pegs) {
        if ([self.pegs containsObject:peg]) {
            <#statements#>
        }
    }
}

@end
