//
//  ViewController.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "BattlefieldController.h"
#import "Game.h"
#import "MinionView.h"

@interface BattlefieldController ()

@property (nonatomic, weak) IBOutlet UILabel* timeLabel;

@property (nonatomic, weak) IBOutlet MinionView* minionH1;
@property (nonatomic, weak) IBOutlet MinionView* minionH2;
@property (nonatomic, weak) IBOutlet MinionView* minionH3;
@property (nonatomic, weak) IBOutlet MinionView* minionH4;
@property (nonatomic, weak) IBOutlet MinionView* minionH5;

@property (nonatomic, weak) IBOutlet MinionView* minionA1;
@property (nonatomic, weak) IBOutlet MinionView* minionA2;
@property (nonatomic, weak) IBOutlet MinionView* minionA3;
@property (nonatomic, weak) IBOutlet MinionView* minionA4;
@property (nonatomic, weak) IBOutlet MinionView* minionA5;

@property (nonatomic, weak) IBOutlet UILabel* manaLabel;

@property (nonatomic, weak) IBOutlet UIImageView* homeImg;
@property (nonatomic, weak) IBOutlet UILabel* homeName;

@property (nonatomic, weak) IBOutlet UIImageView* awayImg;
@property (nonatomic, weak) IBOutlet UILabel* awayName;

@property (weak, nonatomic) IBOutlet UIView *coverView;

@property (nonatomic, strong) Game* game;

@end

@implementation BattlefieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.game = [[Game alloc]init];
    
    self.minionH1.minion = self.game.homePlayer.minion1;
    self.minionH2.minion = self.game.homePlayer.minion2;
    self.minionH3.minion = self.game.homePlayer.minion3;
    self.minionH4.minion = self.game.homePlayer.minion4;
    self.minionH5.minion = self.game.homePlayer.minion5;
    
    self.minionA1.minion = self.game.awayPlayer.minion1;
    self.minionA2.minion = self.game.awayPlayer.minion2;
    self.minionA3.minion = self.game.awayPlayer.minion3;
    self.minionA4.minion = self.game.awayPlayer.minion4;
    self.minionA5.minion = self.game.awayPlayer.minion5;
    
    self.coverView.hidden = YES;
    
    [self update];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)update{
    [self updateTimeLabel];
    [self updateManaLabel];
    
    [self updateHomeUser];
    [self updateAwayUser];
    
    [self.minionH1 update];
    [self.minionH2 update];
    [self.minionH3 update];
    [self.minionH4 update];
    [self.minionH5 update];
    
    [self.minionA1 update];
    [self.minionA2 update];
    [self.minionA3 update];
    [self.minionA4 update];
    [self.minionA5 update];
}

-(void)updateTimeLabel{
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %i",(int)self.game.time];
}

-(void)updateManaLabel{
    self.manaLabel.text = [NSString stringWithFormat:@"Mana: %i",(int)self.game.homePlayer.mana];
}

-(void)updateHomeUser{
    self.homeImg.image = self.game.homePlayer.profileImg;
    self.homeName.text = self.game.homePlayer.username;
}

-(void)updateAwayUser{
    self.awayImg.image = self.game.awayPlayer.profileImg;
    self.awayName.text = self.game.awayPlayer.username;
}

-(IBAction)nextTurn{
    [self.game update];
    [self update];
}

- (IBAction)friendlyMinionSelected:(MinionView *)sender {
    [self performSegueWithIdentifier:@"toSpells" sender:self];
}

- (IBAction)enemyMinionSelected:(MinionView *)sender {
}

-(void)cancelCast{
    
}

-(void)castSpell:(NSObject<Spell> *)spell{
    self.coverView.hidden = NO;
}

@end
