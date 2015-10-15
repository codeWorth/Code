//
//  infoPageViewController.m
//  Milo
//
//  Created by Programming Account on 1/6/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "infoPageViewController.h"

@interface infoPageViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *catImage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end

@implementation infoPageViewController

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
    
    self.catImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.catImage setClipsToBounds:YES];
    
    [self showInfoForCellItem:self.itemToDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showInfoForCellItem:(LeaderItem *)item{
    self.nameLabel.text = item.name;
    self.descLabel.text = item.catDescription;
    if (item.catDescription == nil || [item.catDescription isEqualToString:@""]) {
        self.descLabel.text = @"There is no description here yet.";
    }
    self.catImage.image = item.catPhoto;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", item.score];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
