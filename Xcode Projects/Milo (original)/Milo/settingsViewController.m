//
//  settingsViewController.m
//  Milo
//
//  Created by Programming Account on 1/18/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *catName;
@property (weak, nonatomic) IBOutlet UIImageView *catImage;

@end

@implementation settingsViewController

-(void)updateProfile{
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myImage"];
    UIImage* image = [UIImage imageWithData:imageData];
    self.catImage.image = image;
    
    self.catName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"myName"];
}

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
    
    [self updateProfile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
