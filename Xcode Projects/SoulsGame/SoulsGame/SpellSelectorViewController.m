//
//  SpellSelector.m
//  SoulsGame
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "SpellSelectorViewController.h"
#import "Spell.h"
#import "SpellCell.h"
#import "Fireball.h"
#import "QuickHeal.h"
#import "BattlefieldController.h"

@interface SpellSelectorViewController ()

@property (strong, nonatomic) NSMutableArray* spells;

@property (weak, nonatomic) IBOutlet UIView *spellDetailView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *spellImgView;
@property (weak, nonatomic) IBOutlet UITextView *spellDesc;
@property (weak, nonatomic) IBOutlet UITextView *flavorText;

@property (weak, nonatomic) IBOutlet UITextView *effectList1;
@property (weak, nonatomic) IBOutlet UITextView *effectList2;
@property (weak, nonatomic) IBOutlet UITextView *effectList3;

@property (weak, nonatomic) IBOutlet UILabel *initialLabel;

@property (weak, nonatomic) NSObject<Spell>* selectedSpell;

@end

@implementation SpellSelectorViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.spells = [[NSMutableArray alloc]init];
    
    [self.spells addObject:[[Fireball alloc]init]];
    [self.spells addObject:[[QuickHeal alloc]init]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.spellDetailView.hidden = YES;
    self.initialLabel.hidden = NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toSpells"]){
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Spells";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.spells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* reuseIdentifier = @"spellCell";
    
    SpellCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSObject<Spell>* spell = self.spells[indexPath.row];
    [cell updateWith:spell];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //Disallows editing
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[SpellCell class]]){
        SpellCell* spellCell = (SpellCell*)cell;
        NSObject<Spell>* spell = spellCell.spell;
        
        self.nameLabel.text = spell.name;
        self.spellImgView.image = spell.img;
        self.spellDesc.text = spell.desc;
        self.flavorText.text = spell.flavorText;
        
        self.effectList1.text = @"This minion has no effect on this spell";
        self.effectList2.text = @"";
        self.effectList3.text = @"";
        
        self.spellDetailView.hidden = NO;
        self.initialLabel.hidden = YES;
        
        self.selectedSpell = spell;
    }
}

- (IBAction)cancelSpell:(UIStoryboardSegue*)segue {
    if ([segue.identifier isEqualToString:@"cancel"]){
        [(BattlefieldController*)segue.destinationViewController cancelCast];
    } else if ([segue.identifier isEqualToString:@"cast"]){
        [(BattlefieldController*)segue.destinationViewController castSpell:self.selectedSpell];
    }
}


@end
