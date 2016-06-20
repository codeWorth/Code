//
//  MinionView.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/29/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "MinionView.h"

@interface MinionView ()

@property (nonatomic, weak) IBOutlet UIImageView* backgroundImg;
@property (nonatomic, weak) IBOutlet UIImageView* minionImg;
@property (nonatomic, weak) IBOutlet UILabel* shieldLabel;
@property (nonatomic, weak) IBOutlet UILabel* healthLabel;
@property (nonatomic, weak) IBOutlet UILabel* speedLabel;


@end

@implementation MinionView

-(void)update{
    if (self.minion == nil){
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
    self.shieldLabel.text = @(self.minion.shield.amount).stringValue;
    self.healthLabel.text = @(self.minion.health.amount).stringValue;
    self.speedLabel.text = @(self.minion.speed.amount).stringValue;
    
    self.minionImg.image = [self.minion imgDesc];
}

@end
