//
//  minionScreenViewController.m
//  Souls
//
//  Created by Programming Account on 12/24/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "minionScreenViewController.h"
#import "Minion.h"
#import "SoulStructure.h"
#import "startMinionsViewController.h"

#define COST_PER 2

@interface minionScreenViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *requiredSoul;
@property (weak, nonatomic) IBOutlet UIButton *optionalSoul;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *soulAmoutLabels;
@property (weak, nonatomic) IBOutlet UILabel *soulPointsLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *selectionLabels;
@property (weak, nonatomic) IBOutlet UIButton *resultSoul;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton *summonButton;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *resultImages;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *requiredImages;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *optionalImages;

@property (weak, nonatomic) IBOutlet UIButton *leftArrow;
@property (weak, nonatomic) IBOutlet UIButton *rightArrow;
@property (weak, nonatomic) IBOutlet UIButton *downRight;
@property (weak, nonatomic) IBOutlet UIButton *downLeft;

@property (nonatomic) NSInteger selectedSoulNumber;
@property (strong, nonatomic) NSMutableArray *soulStructures;

@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger posInLevel;

@end

@implementation minionScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundImage.frame.size.width, self.backgroundImage.frame.size.height)];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self.backgroundImage addSubview:overlay];
    
    [self animateLayer:overlay];
    
    [self upadteSoulLabels];
    [self updateSoulPoints];
    [self updateSelectors];
    
    self.level = 0;
    self.posInLevel = 0;
    
    SoulStructure *starter = [[SoulStructure alloc]init];
    starter.isSelected = YES;
    self.soulStructures = [NSMutableArray arrayWithArray:@[starter]];
    
    [self setShownImageToNumber:0 inCollectionArray:self.optionalImages];
    [self setShownImageToNumber:0 inCollectionArray:self.requiredImages];
    
    [self updateArrows];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"lol");
}

 
-(NSArray *)blendAll{
    if (self.soulStructures.count == 1) {
        return [((SoulStructure *)self.soulStructures[0]) topOfStruct].alphas;
    } else if (self.soulStructures.count == 2){
        return [self blendArray:[((SoulStructure *)self.soulStructures[0]) topOfStruct].alphas andOtherArray:[((SoulStructure *)self.soulStructures[1]) topOfStruct].alphas];
    } else if (self.soulStructures.count == 0){
        return @[@(0.0), @(0.0), @(0.0), @(0.0)];
    } else if (self.soulStructures.count > 2){
        NSArray *prev = nil;
        for (SoulStructure *soul in self.soulStructures) {
            if (prev == nil) {
                prev = [soul topOfStruct].alphas;
            } else {
                prev = [self blendArray:prev andOtherArray:[soul topOfStruct].alphas];
            }
        }
    }
    return nil;
}

- (void)animateLayer:(UIView *) layer {
    
    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGFloat alpha;
        CGFloat white;
        [layer.backgroundColor getWhite:&white alpha:&alpha];
        if (alpha == 0.0) {
            [layer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        } else {
            [layer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
        }
    } completion:^(BOOL b) {
        [self animateLayer:layer];
    }];
}

-(BOOL)canSelectTag:(NSInteger)number{
    if (number == 1) {
        if (self.numberOfFire > 0){
            return true;
        }
    } else if (number == 2) {
        if (self.numberOfWater > 0){
            return true;
        }
    } else if (number == 3) {
        if (self.numberOfRock > 0){
            return true;
        }
    } else if (number == 4) {
        if (self.numberOfAir > 0){
            return true;
        }
    }
    return false;
}

-(void)changeForTag:(NSInteger)tag byAmount:(NSInteger)amount{
    if (tag == 1) {
        if (self.numberOfFire > 0){
            self.numberOfFire += amount;
        }
    } else if (tag == 2) {
        if (self.numberOfWater > 0){
            self.numberOfWater += amount;
        }
    } else if (tag == 3) {
        if (self.numberOfRock > 0){
            self.numberOfRock += amount;
        }
    } else if (tag == 4) {
        if (self.numberOfAir > 0){
            self.numberOfAir += amount;
        }
    }
}

-(void)setSelectedSoulNumber:(NSInteger)selectedSoulNumber{
    if (selectedSoulNumber == 0){
        _selectedSoulNumber = selectedSoulNumber;
    } else if (selectedSoulNumber == 1){
        _selectedSoulNumber = selectedSoulNumber;
    } else if (selectedSoulNumber == 2){
        _selectedSoulNumber = selectedSoulNumber;
    } else if (selectedSoulNumber == 3){
        _selectedSoulNumber = selectedSoulNumber;
    } else if (selectedSoulNumber == 4){
        _selectedSoulNumber = selectedSoulNumber;
    }
}

-(void)setLevel:(NSInteger)level{
    _level = level;
    self.levelLabel.text = [NSString stringWithFormat:@"Level %i", _level];
}

- (IBAction)soulButtons:(UIButton *)sender {
    if (sender.tag >= 1 && sender.tag <= 4) {
        if (self.selectedSoulNumber == 0) {
            if ([self canSelectTag:sender.tag]) {
                self.selectedSoulNumber = sender.tag;
                [self updateSelectors];
            }
        } else if (self.selectedSoulNumber != sender.tag){
            if ([self canSelectTag:sender.tag]) {
                self.selectedSoulNumber = sender.tag;
                [self updateSelectors];
            }
            [self upadteSoulLabels];
        }
    }
}

-(SoulStructure *)selectedStructure{
    for (SoulStructure *structure in self.soulStructures) {
        SoulStructure *found = [[structure topOfStruct] findSelected];
        if (found != nil) {
            return found;
        }
    }
    return nil;
}

- (IBAction)arrowButtons:(UIButton *)sender {
    if (sender.tag == 1) {
        if (self.posInLevel == 0) {
            SoulStructure *newStructure = [[SoulStructure alloc]init];
            newStructure.isSelected = YES;
            ((SoulStructure *)self.soulStructures[self.posInLevel]).isSelected = NO;
            [self.soulStructures insertObject:newStructure atIndex:self.posInLevel];
            [self setShownImageToNumber:0 inCollectionArray:self.resultImages];
            [self setShownImageToNumber:0 inCollectionArray:self.requiredImages];
            [self setShownImageToNumber:0 inCollectionArray:self.optionalImages];
            [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
            self.requiredSoul.tag = 0;
            [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
            self.optionalSoul.tag = 0;
        } else {
            if (((SoulStructure *)self.soulStructures[self.posInLevel]).sub1 == nil && ((SoulStructure *)self.soulStructures[self.posInLevel]).sub2 == nil && self.level == 0) {
                [self.soulStructures removeObjectAtIndex:self.posInLevel];
            } else {
                ((SoulStructure *)self.soulStructures[self.posInLevel]).isSelected = NO;
            }
            self.posInLevel--;
            SoulStructure *thisStructure = self.soulStructures[self.posInLevel];
            thisStructure.isSelected = YES;
            [self setAlphasOnArray:self.resultImages fromArray:thisStructure.alphas];
            [self setAlphasOnArray:self.requiredImages fromArray:thisStructure.sub1.alphas];
            [self setAlphasOnArray:self.optionalImages fromArray:thisStructure.sub2.alphas];
            [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
            NSUInteger index = [thisStructure.sub1.alphas indexOfObject:@(1.0)];
            if (index == NSNotFound) {
                self.requiredSoul.tag = 5;
                if (thisStructure.sub1 == nil || [SoulStructure alphasAreZeros:thisStructure.sub1.alphas]) {
                    [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
                    self.requiredSoul.tag = 0;
                }
            } else {
                self.requiredSoul.tag = index + 1;
            }
            [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
            index = [thisStructure.sub2.alphas indexOfObject:@(1.0)];
            if (index == NSNotFound) {
                self.optionalSoul.tag = 5;
                if (thisStructure.sub2 == nil || [SoulStructure alphasAreZeros:thisStructure.sub2.alphas]) {
                    [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
                    self.optionalSoul.tag = 0;
                }
            } else {
                self.optionalSoul.tag = index + 1;
            }
        }
    } else if (sender.tag == 2){
        if (self.soulStructures.count - 1 == self.posInLevel) {
            SoulStructure *newStructure = [[SoulStructure alloc]init];
            newStructure.isSelected = YES;
            ((SoulStructure *)self.soulStructures[self.posInLevel]).isSelected = NO;
            self.posInLevel++;
            [self.soulStructures insertObject:newStructure atIndex:self.posInLevel];
            [self setShownImageToNumber:0 inCollectionArray:self.resultImages];
            [self setShownImageToNumber:0 inCollectionArray:self.requiredImages];
            [self setShownImageToNumber:0 inCollectionArray:self.optionalImages];
            [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
            self.requiredSoul.tag = 0;
            [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
            self.optionalSoul.tag = 0;
        } else {
            if (((SoulStructure *)self.soulStructures[self.posInLevel]).sub1 == nil && ((SoulStructure *)self.soulStructures[self.posInLevel]).sub2 == nil) {
                [self.soulStructures removeObjectAtIndex:self.posInLevel];
            } else {
                ((SoulStructure *)self.soulStructures[self.posInLevel]).isSelected = NO;
                self.posInLevel++;
            }
            SoulStructure *thisStructure = self.soulStructures[self.posInLevel];
            thisStructure.isSelected = YES;
            [self setAlphasOnArray:self.resultImages fromArray:thisStructure.alphas];
            [self setAlphasOnArray:self.requiredImages fromArray:thisStructure.sub1.alphas];
            [self setAlphasOnArray:self.optionalImages fromArray:thisStructure.sub2.alphas];
            [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
            NSUInteger index = [thisStructure.sub1.alphas indexOfObject:@(1.0)];
            if (index == NSNotFound) {
                self.requiredSoul.tag = 5;
                if (thisStructure.sub1 == nil || [SoulStructure alphasAreZeros:thisStructure.sub1.alphas]) {
                    [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
                    self.requiredSoul.tag = 0;
                }
            } else {
                self.requiredSoul.tag = index + 1;
            }
            [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
            index = [thisStructure.sub2.alphas indexOfObject:@(1.0)];
            if (index == NSNotFound) {
                self.optionalSoul.tag = 5;
                if (thisStructure.sub2 == nil || [SoulStructure alphasAreZeros:thisStructure.sub2.alphas]) {
                    [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
                    self.optionalSoul.tag = 0;
                }
            } else {
                self.optionalSoul.tag = index + 1;
            }
        }
    } else if (sender.tag == 3){
        [self goDownLeft];
    } else if (sender.tag == 4){
        [self goDownRight];
    }
    [self updateArrows];
}

- (IBAction)requiredSoulButton:(UIButton *)sender {
    if (sender.tag == 0 && self.selectedSoulNumber >= 1){
        [self setShownImageToNumber:self.selectedSoulNumber inCollectionArray:self.requiredImages];
        sender.tag = self.selectedSoulNumber;
        [sender setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        
        [self selectedStructure].sub1 = [[SoulStructure alloc]initAsRootWithType:[self typeFromNumber:sender.tag] andAlphas:[self alphasFromArray:self.requiredImages]];
        
        [self changeForTag:sender.tag byAmount:-1];
        [self upadteSoulLabels];
        self.costToCreate += COST_PER;
        [self updateSoulPoints];
        self.selectedSoulNumber = 0;
        [self updateSelectors];
    } else if (sender.tag >= 1){
        if ([self selectedStructure].sub1.isRoot) {
            [self changeForTag:sender.tag byAmount:1];
            if (self.selectedSoulNumber > 0){
                [self setShownImageToNumber:self.selectedSoulNumber inCollectionArray:self.requiredImages];
                sender.tag = self.selectedSoulNumber;
                [sender setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
                
                [self changeForTag:sender.tag byAmount:-1];
                [self upadteSoulLabels];
                [self updateSoulPoints];
                self.selectedSoulNumber = 0;
                [self updateSelectors];
                [self selectedStructure].sub1 = [[SoulStructure alloc]initAsRootWithType:[self typeFromNumber:sender.tag] andAlphas:[self alphasFromArray:self.requiredImages]];
            } else {
                [self setShownImageToNumber:0 inCollectionArray:self.requiredImages];
                [sender setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
                sender.tag = 0;
                [self upadteSoulLabels];
                self.costToCreate -= COST_PER;
                [self updateSoulPoints];
                [self selectedStructure].sub1 = nil;
            }
        }
    } else {
        [self downLeft];
    }
    [self updateArrows];
}

- (IBAction)optionalSoulButton:(UIButton *)sender {
    if (sender.tag == 0 && self.selectedSoulNumber >= 1){
        [self setShownImageToNumber:self.selectedSoulNumber inCollectionArray:self.optionalImages];
        sender.tag = self.selectedSoulNumber;
        [sender setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        
        [self selectedStructure].sub2 = [[SoulStructure alloc]initAsRootWithType:[self typeFromNumber:sender.tag] andAlphas:[self alphasFromArray:self.optionalImages]];
        
        [self changeForTag:sender.tag byAmount:-1];
        [self upadteSoulLabels];
        self.costToCreate += COST_PER;
        [self updateSoulPoints];
        self.selectedSoulNumber = 0;
        [self updateSelectors];
    } else if (sender.tag >= 1){
        if ([self selectedStructure].sub2.isRoot) {
            [self changeForTag:sender.tag byAmount:1];
            if (self.selectedSoulNumber > 0){
                [self setShownImageToNumber:self.selectedSoulNumber inCollectionArray:self.optionalImages];
                sender.tag = self.selectedSoulNumber;
                [sender setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
                
                [self changeForTag:sender.tag byAmount:-1];
                [self upadteSoulLabels];
                [self updateSoulPoints];
                self.selectedSoulNumber = 0;
                [self updateSelectors];
                [self selectedStructure].sub2 = [[SoulStructure alloc]initAsRootWithType:[self typeFromNumber:sender.tag] andAlphas:[self alphasFromArray:self.optionalImages]];
            } else {
                [self setShownImageToNumber:0 inCollectionArray:self.optionalImages];
                [sender setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
                sender.tag = 0;
                [self upadteSoulLabels];
                self.costToCreate -= COST_PER;
                [self updateSoulPoints];
                [self selectedStructure].sub2 = nil;
            }
        }
    } else {
        [self downRight];
    }
    [self updateArrows];
}

- (IBAction)resultButton:(UIButton *)sender {
    //up
    self.level++;
    SoulStructure *parent;
    if ([self selectedStructure].parent == nil) {
        parent = [[SoulStructure alloc]initAsParentForSub1:[self selectedStructure]];
        [self selectedStructure].isSelected = NO;
        [self setShownImageToNumber:0 inCollectionArray:self.resultImages];
        [self setAlphasOnArray:self.requiredImages fromArray:parent.sub1.alphas];
        [self setShownImageToNumber:0 inCollectionArray:self.optionalImages];
        [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        NSUInteger index = [parent.sub1.alphas indexOfObject:@(1.0)];
        if (index == NSNotFound) {
            self.requiredSoul.tag = 5;
            if (parent.sub1 == nil || [SoulStructure alphasAreZeros:parent.sub1.alphas]) {
                [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
                self.requiredSoul.tag = 0;
            }
        } else {
            self.requiredSoul.tag = index + 1;
        }
        [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        self.optionalSoul.tag = 0;
    } else {
        parent = [self selectedStructure].parent;
        if ([self isEmpty:[self selectedStructure].sub1] && [self isEmpty:[self selectedStructure].sub2]) {
            if ([self selectedStructure].parent.sub1.isSelected) {
                [self selectedStructure].parent.sub1 = nil;
            } else {
                [self selectedStructure].parent.sub2 = nil;
            }
        }
        [self selectedStructure].isSelected = NO;
        [self setAlphasOnArray:self.resultImages fromArray:parent.alphas];
        [self setAlphasOnArray:self.requiredImages fromArray:parent.sub1.alphas];
        [self setAlphasOnArray:self.optionalImages fromArray:parent.sub2.alphas];
        [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        NSUInteger index = [parent.sub1.alphas indexOfObject:@(1.0)];
        if (index == NSNotFound) {
            self.requiredSoul.tag = 5;
            if (parent.sub1 == nil || [SoulStructure alphasAreZeros:parent.sub1.alphas]) {
                [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
                self.requiredSoul.tag = 0;
            }
        } else {
            self.requiredSoul.tag = index + 1;
        }
        [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        index = [parent.sub2.alphas indexOfObject:@(1.0)];
        if (index == NSNotFound) {
            self.optionalSoul.tag = 5;
            if (parent.sub2 == nil || [SoulStructure alphasAreZeros:parent.sub2.alphas]) {
                [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
                self.optionalSoul.tag = 0;
            }
        } else {
            self.optionalSoul.tag = index + 1;
        }
    }
    parent.isSelected = YES;
    [self updateArrows];
    [self updateSoulPoints];
    
}

-(void) upadteSoulLabels {
    for (UILabel *label in self.soulAmoutLabels) {
        if (label.tag == 1) {
            label.text = [NSString stringWithFormat:@"x%i", self.numberOfFire];
        } else if (label.tag == 2) {
            label.text = [NSString stringWithFormat:@"x%i", self.numberOfWater];
        } else if (label.tag == 3) {
            label.text = [NSString stringWithFormat:@"x%i", self.numberOfRock];
        } else if (label.tag == 4) {
            label.text = [NSString stringWithFormat:@"x%i", self.numberOfAir];
        }
    }
}

-(void) updateSoulPoints {
    self.soulPointsLabel.text = [NSString stringWithFormat:@"This will cost you %i Soul Points. You have %i Soul Points.", self.costToCreate, self.numberOfSoulPoints];
    for (int i = 1; i <= 4; i++) {
        [self viewWithTag:i inArray:self.resultImages].hidden = YES;
    }
    if (self.requiredSoul.tag > 0 && self.optionalSoul.tag > 0) {
        NSArray *resultBlend = [self blendArray:[self alphasFromArray:self.requiredImages] andOtherArray:[self alphasFromArray:self.optionalImages]];
        [self setAlphasOnArray:self.resultImages fromArray:resultBlend];
        [self selectedStructure].alphas = resultBlend;
    }
    if (self.costToCreate > 0 && self.costToCreate <= self.numberOfSoulPoints) {
        self.summonButton.enabled = YES;
    } else {
        self.summonButton.enabled = NO;
    }
}

-(void)setAlphasOnArray:(NSArray *)views fromArray:(NSArray *)alphas{
    for (int i = 1; i <= views.count; i++) {
        [self viewWithTag:i inArray:views].alpha = ((NSNumber *)alphas[i-1]).doubleValue;
        if (((NSNumber *)alphas[i-1]).doubleValue > 0) {
            [self viewWithTag:i inArray:views].hidden = NO;
        }
    }
}

-(void) updateSelectors {
    for (UIImageView *view in self.selectionLabels) {
        view.hidden = YES;
    }
    if (self.selectedSoulNumber >= 1){
        [self viewWithTag:self.selectedSoulNumber inArray:self.selectionLabels].hidden = NO;
    }
}

-(UIView *)viewWithTag:(NSInteger)tag inArray:(NSArray *)array{
    for (UIView *view in array) {
        if (view.tag == tag){
            return view;
        }
    }
    return nil;
}

-(NSString *)typeFromNumber:(NSInteger)number{
    if (number == 1) {
        return @"Fire";
    } else if (number == 2) {
        return @"Water";
    } else if (number == 3) {
        return @"Rock";
    } else if (number == 4) {
        return @"Air";
    }
    return nil;
}

-(NSArray *)alphasFromArray:(NSArray *)array{
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 1;i <= array.count;i++) {
        if ([self viewWithTag:i inArray:array].hidden) {
            [result addObject:@(0.0)];
        } else {
            [result addObject:@([self viewWithTag:i inArray:array].alpha)];
        }
    }
    return result;
}

-(NSArray *)blendArray:(NSArray *)array1 andOtherArray:(NSArray *)array2{
    NSMutableArray *values = [NSMutableArray array];
    for (int i = 0;i < array1.count;i++) {
        [values addObject:[NSNumber numberWithDouble:(((NSNumber *)array1[i]).doubleValue + ((NSNumber *)array2[i]).doubleValue)/2]];
    }
    return values;
}

-(void)setShownImageToNumber:(NSInteger)imageNumber inCollectionArray:(NSArray *)array{
    for (UIView *view in array) {
        if (view.tag == imageNumber) {
            view.hidden = NO;
            view.alpha = 1;
        } else {
            view.hidden = YES;
        }
    }
}

-(void)setShownImageToNumber:(NSInteger)imageNumber inCollectionArray:(NSArray *)array andSetAlpha:(double)alpha{
    for (UIView *view in array) {
        if (view.tag == imageNumber) {
            view.hidden = NO;
            view.alpha = alpha;
        } else {
            view.hidden = YES;
        }
    }
}

-(void)updateArrows{
    if (self.level == 0) {
        self.leftArrow.enabled = YES;
        self.rightArrow.enabled = YES;
        if ([self selectedStructure].sub1 == nil || [self selectedStructure].sub2 == nil) {
            if (self.posInLevel == 0) {
                self.leftArrow.enabled = NO;
            }
            if (self.posInLevel == self.soulStructures.count - 1) {
                self.rightArrow.enabled = NO;
            }
        }
    } else {
        self.leftArrow.enabled = NO;
        self.rightArrow.enabled = NO;
    }
    
    if (self.requiredSoul.tag > 0 && self.optionalSoul.tag > 0) {
        self.resultSoul.enabled = YES;
    } else {
        self.resultSoul.enabled = NO;
    }
    
    if (self.requiredSoul.tag > 0 && self.requiredSoul.tag <= 4) {
        self.downLeft.enabled = NO;
    } else {
        self.downLeft.enabled = YES;
    }
    
    if (self.optionalSoul.tag > 0 && self.optionalSoul.tag <= 4) {
        self.downRight.enabled = NO;
    } else {
        self.downRight.enabled = YES;
    }
}

-(BOOL)structuresAreSafe{
    for (SoulStructure *structure in self.soulStructures) {
        if (![[structure topOfStruct] isSafeStructure]) {
            return NO;
        }
    }
    return YES;
}

-(void)goDownLeft{
    self.level--;
    if ([self selectedStructure].sub1 == nil) {
        SoulStructure *child = [[SoulStructure alloc]init];
        child.parent = [self selectedStructure];
        [self selectedStructure].sub1 = child;
        [self selectedStructure].isSelected = NO;
        child.isSelected = YES;
        
        [self setShownImageToNumber:0 inCollectionArray:self.resultImages];
        [self setShownImageToNumber:0 inCollectionArray:self.requiredImages];
        [self setShownImageToNumber:0 inCollectionArray:self.optionalImages];
        [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
        self.requiredSoul.tag = 0;
        [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        self.optionalSoul.tag = 0;
    } else {
        SoulStructure *child = [self selectedStructure].sub1;
        
        if ([self isEmpty:[self selectedStructure].sub2] && [self isEmpty:[self selectedStructure]]) {
            child.parent = nil;
            if ([self selectedStructure].sub2.isRoot) {
                [self selectedStructure].sub2 = nil;
            } else {
                [self selectedStructure].sub2.sub1.parent = nil;
                [self selectedStructure].sub2.sub2.parent = nil;
                [self selectedStructure].sub2.parent = nil;
            }
        }
        
        [self selectedStructure].isSelected = NO;
        child.isSelected = YES;
        
        [self setAlphasOnArray:self.resultImages fromArray:child.alphas];
        [self setAlphasOnArray:self.requiredImages fromArray:child.sub1.alphas];
        [self setAlphasOnArray:self.optionalImages fromArray:child.sub2.alphas];
        [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        NSUInteger index = [child.sub1.alphas indexOfObject:@(1.0)];
        if (index == NSNotFound) {
            self.requiredSoul.tag = 5;
            if (child.sub1 == nil || [SoulStructure alphasAreZeros:child.sub1.alphas]) {
                [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
                self.requiredSoul.tag = 0;
            }
        } else {
            self.requiredSoul.tag = index + 1;
        }
        [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        index = [child.sub2.alphas indexOfObject:@(1.0)];
        if (index == NSNotFound) {
            self.optionalSoul.tag = 5;
            if (child.sub2 == nil || [SoulStructure alphasAreZeros:child.sub2.alphas]) {
                [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
                self.optionalSoul.tag = 0;
            }
        } else {
            self.optionalSoul.tag = index + 1;
        }
    }
    [self updateSoulPoints];
}

-(void)goDownRight{
    self.level--;
    if ([self selectedStructure].sub2 == nil) {
        SoulStructure *child = [[SoulStructure alloc]init];
        child.parent = [self selectedStructure];
        [self selectedStructure].sub2 = child;
        [self selectedStructure].isSelected = NO;
        child.isSelected = YES;
        
        [self setShownImageToNumber:0 inCollectionArray:self.resultImages];
        [self setShownImageToNumber:0 inCollectionArray:self.requiredImages];
        [self setShownImageToNumber:0 inCollectionArray:self.optionalImages];
        [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
        self.requiredSoul.tag = 0;
        [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        self.optionalSoul.tag = 0;
    } else {
        SoulStructure *child = [self selectedStructure].sub2;
        
        if ([self isEmpty:[self selectedStructure].sub1] && [self isEmpty:[self selectedStructure]]) {
            child.parent = nil;
            if ([self selectedStructure].sub1.isRoot) {
                [self selectedStructure].sub1 = nil;
            } else {
                [self selectedStructure].sub1.sub1.parent = nil;
                [self selectedStructure].sub1.sub2.parent = nil;
                [self selectedStructure].sub1.parent = nil;
            }
        }
        
        [self selectedStructure].isSelected = NO;
        child.isSelected = YES;
        
        [self setAlphasOnArray:self.resultImages fromArray:child.alphas];
        [self setAlphasOnArray:self.requiredImages fromArray:child.sub1.alphas];
        [self setAlphasOnArray:self.optionalImages fromArray:child.sub2.alphas];
        [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        NSUInteger index = [child.sub1.alphas indexOfObject:@(1.0)];
        if (index == NSNotFound) {
            self.requiredSoul.tag = 5;
            if (child.sub1 == nil || [SoulStructure alphasAreZeros:child.sub1.alphas]) {
                [self.requiredSoul setBackgroundImage:[UIImage imageNamed:@"requiredSoul.png"] forState:UIControlStateNormal];
                self.requiredSoul.tag = 0;
            }
        } else {
            self.requiredSoul.tag = index + 1;
        }
        [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        index = [child.sub2.alphas indexOfObject:@(1.0)];
        if (index == NSNotFound) {
            self.optionalSoul.tag = 5;
            if (child.sub2 == nil || [SoulStructure alphasAreZeros:child.sub2.alphas]) {
                [self.optionalSoul setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
                self.optionalSoul.tag = 0;
            }
        } else {
            self.optionalSoul.tag = index + 1;
        }
    }
    [self updateSoulPoints];
}

- (IBAction)summonButton:(UIButton *)sender {
    if ([self structuresAreSafe]) {
        /*if (self.numberToSet == 1) {
            ((startMinionsViewController *)[self presentingViewController]).lowerLeftAlphas = [self blendAll];
        } else if (self.numberToSet == 2) {
            ((startMinionsViewController *)[self presentingViewController]).lowerRightAlphas = [self blendAll];
        } else if (self.numberToSet == 3) {
            ((startMinionsViewController *)[self presentingViewController]).middleLeftAlpas = [self blendAll];
        } else if (self.numberToSet == 4) {
            ((startMinionsViewController *)[self presentingViewController]).middleRightAlphas = [self blendAll];
        } else if (self.numberToSet == 5) {
            ((startMinionsViewController *)[self presentingViewController]).upperAlphas = [self blendAll];
        }*/
        [[self presentingViewController]dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Minion" message:@"Your minion structure is invalid. Please fix the problems and try again." delegate:nil cancelButtonTitle:@"Ok." otherButtonTitles:nil];
        [alert show];
    }
}

-(BOOL)isEmpty:(SoulStructure *)structure{
    if ([structure.type isEqualToString:@""] || structure == nil) {
        return YES;
    } else {
        return NO;
    }
}

@end
