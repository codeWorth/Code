//
//  startScreenViewController.m
//  Stand-Off
//
//  Created by Programming Account on 8/19/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "startScreenViewController.h"

#define MAX_PLAYERS 4

@interface startScreenViewController ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *bulletHolesAndTitle;
@property (weak, nonatomic) IBOutlet UIImageView *numberOfPlayers;
@property (weak, nonatomic) IBOutlet UIImageView *playersWords;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *lessButton;
@property (nonatomic) NSInteger numOfPlayers;

@end

@implementation startScreenViewController

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
    self.numOfPlayers = 4;
    
    [self.navigationController setNavigationBarHidden: YES animated:NO];
    [self.numberOfPlayers setHidden:YES];
    [self.playersWords setHidden:YES];
    [self.startButton setHidden:YES];
    [self.moreButton setHidden:YES];
    [self.lessButton setHidden:YES];
    for (UIImageView *thisImage in self.bulletHolesAndTitle){
        [thisImage setHidden:YES];
    }
    [self performSelector:@selector(first) withObject:nil afterDelay:1];
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

-(void)first{
    [[self imageWithTagFromCollection:0] setHidden:NO];
    [self playNormalGun];
    [self performSelector:@selector(second) withObject:nil afterDelay:0.65];
}

-(void)second{
    [[self imageWithTagFromCollection:1] setHidden:NO];
    [self playNormalGun];
    [self performSelector:@selector(third) withObject:nil afterDelay:0.65];
}

-(void)third{
    [[self imageWithTagFromCollection:2] setHidden:NO];
    [self playNormalGun];
    [self performSelector:@selector(fourth) withObject:nil afterDelay:0.65];
}

-(void)fourth{
    [[self imageWithTagFromCollection:3] setHidden:NO];
    [self playNormalGun];
    [self performSelector:@selector(fifth) withObject:nil afterDelay:0.65];
}

-(void)fifth{
    [[self imageWithTagFromCollection:4] setHidden:NO];
    [self playNormalGun];
    [self performSelector:@selector(sixth) withObject:nil afterDelay:0.65];
}

-(void)sixth{
    [[self imageWithTagFromCollection:5] setHidden:NO];
    [self playNormalGun];
    [self performSelector:@selector(last) withObject:nil afterDelay:0.65];
}

-(void)last{
    [[self imageWithTagFromCollection:6] setHidden:NO];
    [self playPowerfulGun];
    [self performSelector:@selector(allUI) withObject:nil afterDelay:1];
}

-(void)allUI{
    [self.playersWords setHidden:NO];
    [self.numberOfPlayers setHidden:NO];
    [self.startButton setHidden:NO];
    [self.moreButton setHidden:NO];
    [self.lessButton setHidden:NO];
}

-(void)playNormalGun{
    SystemSoundID soundID;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Gun_Fire.mp3", [[NSBundle mainBundle] resourcePath]]];

    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound (soundID);
}

-(void)playPowerfulGun{
    SystemSoundID soundID;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/Sniper_Rifle.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound (soundID);
}

-(UIImageView *)imageWithTagFromCollection:(int)tag{
    UIImageView *image = nil;
    int i = 0;
    while (image == nil && i < [self.bulletHolesAndTitle count]) {
        UIImageView *thisImage = self.bulletHolesAndTitle[i];
        if (thisImage.tag == tag + 1){
            image = self.bulletHolesAndTitle[i];
        }
        i++;
    }
    return image;
}

- (IBAction)morePlayers {
    if (self.numOfPlayers < MAX_PLAYERS){
        self.numOfPlayers++;
        self.numberOfPlayers.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png",self.numOfPlayers]];
    }
}

- (IBAction)lessPlayers {
    if (self.numOfPlayers > 2){
        self.numOfPlayers--;
        self.numberOfPlayers.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.png",self.numOfPlayers]];
    }
}

@end
