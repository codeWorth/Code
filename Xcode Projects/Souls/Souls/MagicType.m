//
//  MagicType.m
//  Souls
//
//  Created by Programming Account on 4/1/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "MagicType.h"
#import "Soul.h"
#import "Minion.h"

@interface MagicType ()

-(NSInteger)numOfLevels;

-(double)interactWithSoul:(Soul *)soul; //what bonuses or decreases in damage this type receives when cast by the specified soul. Should only be used within interactWithMinon.
-(double)blockSoul:(Soul *)soul; //what bonuses or decreases in damage this type receives when is cast onto by the specified soul. Should only be used within amountAfterBlockedByMinion.

@end

@implementation MagicType

-(double)interactWithSoul:(Soul *)soul{
    NSArray *typePair = @[self.type, soul.type]; //makes an array so that the if statements dont have to check for both ways of combining two types.
    double mult = 1;
    
    if ([soul.creatorSouls count] == 0 && [self.creatorMagic count] == 0) { //if both are the base types, just use the built conversion and combination.
        if ([typePair containsObject:@"Fire"] && [typePair containsObject:@"Water"]) {
            mult = 1-0.35;
        } else if ([typePair containsObject:@"Fire"] && [typePair containsObject:@"Earth"]) {
            mult = 1-0.2;
        } else if ([typePair containsObject:@"Fire"] && [typePair containsObject:@"Air"]) {
            mult = 1-0.25;
        } else if ([typePair containsObject:@"Water"] && [typePair containsObject:@"Earth"]) {
            mult = 1-0.1;
        } else if ([typePair containsObject:@"Water"] && [typePair containsObject:@"Air"]) {
            mult = 1-0.15;
        } else if ([typePair containsObject:@"Earth"] && [typePair containsObject:@"Air"]) {
            mult = 1-0.25;
        } else {
            if ([typePair[0] isEqualToString:typePair[1]]) {
                if ([typePair[0] isEqualToString:@"Fire"]) {
                    mult = 1+0.5;
                } else if ([typePair[0] isEqualToString:@"Water"]) {
                    mult = 1+0.35;
                } else if ([typePair[0] isEqualToString:@"Earth"]) {
                    mult = 1+0.4;
                } else if ([typePair[0] isEqualToString:@"Air"]) {
                    mult = 1+0.45;
                }
            }
        }
    } else { //Otherwise, iterate through the magics combining them.
        for (MagicType* currentMagic in self.creatorMagic) {
            for (Soul* currentSoul in soul.creatorSouls) {
                double add = [currentMagic interactWithSoul:currentSoul];
                double addon = 0;
                if ([currentMagic.type isEqualToString:currentSoul.type]) {
                    NSInteger numBelow = [self numOfLevels] - 1;
                    if (add - 1 > 0) {
                        addon = (add - 1) * (1.5 + numBelow*0.5); //changes how much mult increases by depending on how many levels down the soul is.
                    } else {
                        addon = (1 - add) * (1.5 + numBelow*0.5);
                    }
                    
                }
                mult = mult + (add-1) + addon;
            }
        }
        
    }
    
    return mult; //return what this magic's amount should be multiplied by.
}

-(double)interactWithMinion:(Minion *)minion{
    double amount = 0;
    
    for (Soul *currentSoul in minion.souls) { //returns the sum of the minion's souls interaction with the magic
        amount = amount + [self interactWithSoul:currentSoul];
    }
    
    return amount;
}

-(double)blockSoul:(Soul *)soul{ //essentially the same as interact, but the orientation (i.e. soul: fire and minion: water is different then soul: water and minion: fire) matters and the combination method is simplified.
    double mult = 1;
    
    if ([soul.creatorSouls count] == 0 && [self.creatorMagic count]== 0) {
        if ([soul.type isEqualToString:self.type]) {
            if ([self.type isEqualToString:@"Fire"]) {
                mult = 0.95;
            } else if ([self.type isEqualToString:@"Water"]) {
                mult = 0.85;
            } else if ([self.type isEqualToString:@"Earth"]) {
                mult = 0.75;
            } else if ([self.type isEqualToString:@"Air"]) {
                mult = 0.9;
            }
        }else if ([self.type isEqualToString:@"Fire"]) {
            if ([soul.type isEqualToString:@"Water"]) {
                mult = 0.85;
            } else if ([soul.type isEqualToString:@"Earth"]) {
                mult = 0.65;
            } else if ([soul.type isEqualToString:@"Air"]) {
                mult = 0.9;
            }
        }else if ([self.type isEqualToString:@"Water"]) {
            if ([soul.type isEqualToString:@"Fire"]) {
                mult = 0.9;
            } else if ([soul.type isEqualToString:@"Earth"]) {
                mult = 0.85;
            } else if ([soul.type isEqualToString:@"Air"]) {
                mult = 0.95;
            }
        }else if ([self.type isEqualToString:@"Earth"]) {
            if ([soul.type isEqualToString:@"Water"]) {
                mult = 0.8;
            } else if ([soul.type isEqualToString:@"Fire"]) {
                mult = 0.9;
            } else if ([soul.type isEqualToString:@"Air"]) {
                mult = 0.85;
            }
        }else if ([self.type isEqualToString:@"Air"]) {
            if ([soul.type isEqualToString:@"Water"]) {
                mult = 0.95;
            } else if ([soul.type isEqualToString:@"Earth"]) {
                mult = 0.9;
            } else if ([soul.type isEqualToString:@"Fire"]) {
                mult = 0.95;
            }
        }
    } else {
        for (MagicType* currentMagic in self.creatorMagic) {
            for (Soul* currentSoul in soul.creatorSouls) {
                double add = [currentMagic blockSoul:currentSoul];
                mult = mult + (add - 1);
            }
        }
    }
    
    return mult;
}

-(double)blockMinion:(Minion *)minion{ //the same as interacting, except with the "amountBlocked" method.
    double amount = 0;
    for (Soul *soul in minion.souls) {
        amount = amount + [self blockSoul:soul];
    }
    return amount;
}

-(BOOL)isEqual:(id)otherMagic{
    if ([otherMagic isKindOfClass:self.class]) {
        MagicType *other = otherMagic;
        if ([self.type isEqualToString:other.type]) {
            return YES;
        }
    }
    return NO;
}

-(id)initWithMagic:(MagicType *)magic1 otherMagic:(MagicType *)magic2 andAmount:(double)amount{
    if(self = [super init]) {
        if ([MagicType typeFromType:magic1.type andOtherType:magic2.type]) {
            self.type = [MagicType typeFromType:magic1.type andOtherType:magic2.type];
        } else {
            return NO;
        }
        self.amount = amount;
    }
    return self;
}


+(NSString *)typeFromType:(NSString *)type1 andOtherType:(NSString *)type2{ //combinations of different types, will be expanded in the future for more types of magic.
    NSArray *typeList = [[NSArray alloc]initWithObjects:type1, type2, nil];
    if ([typeList containsObject:@"Fire"] && [typeList containsObject:@"Water"]) {
        return @"Steam";
    } else if ([typeList containsObject:@"Fire"] && [typeList containsObject:@"Earth"]) {
        return @"Lava";
    } else if ([typeList containsObject:@"Fire"] && [typeList containsObject:@"Air"]) {
        return @"Explosion";
    } else if ([typeList containsObject:@"Water"] && [typeList containsObject:@"Earth"]) {
        return @"Life";
    } else if ([typeList containsObject:@"Water"] && [typeList containsObject:@"Air"]) {
        return @"Snow";
    } else if ([typeList containsObject:@"Earth"] && [typeList containsObject:@"Air"]) {
        return @"Duststorm";
        //end of basic combonations, start of secondary
    } else if ([typeList containsObject:@"Water"] && [typeList containsObject:@"Lava"]){
        return @"Metal";
    } else if ([typeList containsObject:@"Snow"] && [typeList containsObject:@"Earth"]){
        return @"Ice";
    } else if ([typeList containsObject:@"Life"] && [typeList containsObject:@"Fire"]){
        return @"Oil";
    } else if ([typeList containsObject:@"Steam"] && [typeList containsObject:@"Water"]){
        return @"Hurricane";
    } else if ([typeList containsObject:@"Steam"] && [typeList containsObject:@"Earth"]){
        return @"Tornado";
    } else if ([typeList containsObject:@"Lava"] && [typeList containsObject:@"Air"]){
        return @"Acid";
    } else if ([typeList containsObject:@"Life"] && [typeList containsObject:@"Air"]){
        return @"Avion Animals";
    } else if ([typeList containsObject:@"Life"] && [typeList containsObject:@"Water"]){
        return @"Aquatic Animals";
    } else if ([typeList containsObject:@"Life"] && [typeList containsObject:@"Earth"]){
        return @"Terrestrial Animals";
    } else if ([typeList containsObject:@"Snow"] && [typeList containsObject:@"Earth"]){
        return @"Avalanche";
    } else if ([type1 isEqualToString:type2]){
        return [NSString stringWithFormat:@"Super %@",type1]; //if "fire" + "fire", or such makes "super fire", when expanded will add "fire" + "super fire" = "extra super fire", and will add test "super fire" + "super fire" because that should not be "super fire" again.
    } else {
        return @"NO";
    }
}

-(NSInteger)numOfLevels{ //the number of levels in a magic (i.e. fire has 0, but super fire has 1.
    if ([self.creatorMagic count]>0) {
        NSInteger below1 = [self.creatorMagic[0] numOfLevels];
        NSInteger below2 = [self.creatorMagic[1] numOfLevels];
        NSInteger maximum = 0;
        if (below1 >= below2) {
            maximum = below1;
        } else {
            maximum = below2;
        }
        return 1 + maximum;
    } else {
        return 0;
    }
}

+(NSMutableArray *)combineMagicList:(NSArray *)array1 andOtherMagicList:(NSMutableArray *)array2{
    for (int i = 0; i < [array1 count]; i++) {
        NSInteger index = [array2 indexOfObject:array1[i]]; //tries to find another magic where othermagic.type == thismagic.type.
        MagicType* magic1 = array1[i];
        if (index != NSNotFound) { //if a match has been found:
            MagicType* magic2 = array2[index];
            magic1.amount = magic1.amount + magic2.amount; //combine the amounts.
            [array2 replaceObjectAtIndex:index withObject:magic1];
        } else { //otherwise:
            [array2 addObject:magic1]; //just add it on to the bottom.
        }
    }
    return array2;
}

+(NSMutableArray *)combineMagicList:(NSMutableArray *)array withMagic:(MagicType *)magic{
    NSInteger index = [array indexOfObject:magic]; //checks if a magic with matching type exists
    if (index == NSNotFound) { //if not,
        [array addObject:magic]; //it just adds on the magic.
    } else { //otherwise,
        MagicType *selectedMagic = array[index];
        selectedMagic.amount = selectedMagic.amount + magic.amount; //it combines the amounts.
        [array replaceObjectAtIndex:index withObject:selectedMagic];
    }
    return array;
}

-(MagicType *)copy{ //a deep copy
    MagicType *copy = [[MagicType alloc]init];
    copy.type = [self.type copy]; //I believe that the default NSString and NSArray copy methods are both deep, but the documentation is not 100% clear.
    copy.creatorMagic = [self.creatorMagic copy]; //This copy method should send copy to all of it's items, and they are all MagicTypes, so this should be a deep copy also.
    copy.amount = self.amount;
    return copy;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeDouble:self.amount forKey:@"amount"];
    [aCoder encodeObject:self.creatorMagic forKey:@"creatorMagic"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        [aDecoder decodeObjectForKey:@"type"];
        [aDecoder decodeDoubleForKey:@"amount"];
        [aDecoder decodeObjectForKey:@"creatorMagic"];
    }
    return self;
}

@end
