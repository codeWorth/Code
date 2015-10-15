//
//  counterViewController.m
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "counterViewController.h"
#import "challengeViewController.h"
#import "miloAppDelegate.h"

@interface counterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *miloImage;

@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation counterViewController

NSURL *hitSoundUrl;

-(void)setScore:(NSInteger)score{
    _score = score;
    [[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:@"score"];
    [self updateScore];
}

-(NSMutableArray *)activityLogs{
    if (_activityLogs == nil) {
        _activityLogs = [NSMutableArray array];
    }
    return _activityLogs;
}

+(void)updateScoreForChallenge:(challengeViewController *)view{
    NSDate *date = [NSDate date];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    NSString *dayString = [dateString componentsSeparatedByString:@","][0];
    NSString *timeString = [dateString componentsSeparatedByString:@","][2];
    if (view.activityLogs.count > 0) {
        NSArray *prevParts = [(NSString *)view.activityLogs[0] componentsSeparatedByString:@"$"];
        if ([dayString isEqualToString:prevParts[0]] && [timeString isEqualToString:prevParts[1]]) {
            NSInteger prevCount = (int)prevParts[2];
            NSString *newEntry = [NSString stringWithFormat:@"%@$%@$%li",prevParts[0],prevParts[1],prevCount+1];
            [view.activityLogs replaceObjectAtIndex:0 withObject:newEntry];
        }
    } else {
        [view.activityLogs insertObject:[NSString stringWithFormat:@"%@$%@$1",dayString,timeString] atIndex:0];
    }
    if (view.activityLogs.count > 10) {
        [view.activityLogs removeObjectAtIndex:10];
    }
    [[NSUserDefaults standardUserDefaults] setObject:view.activityLogs forKey:@"activityLog"];
}

+(void)updateScoreForCounter:(counterViewController *)view{
    NSDate *date = [NSDate date];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
    NSString *dayString = [dateString componentsSeparatedByString:@","][0];
    NSString *timeString = [dateString componentsSeparatedByString:@","][2];
    timeString = [timeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (view.activityLogs.count > 0) {
        NSArray *prevParts = [(NSString *)view.activityLogs[0] componentsSeparatedByString:@"$"];
        if ([dayString isEqualToString:prevParts[0]] && [timeString isEqualToString:prevParts[1]]) {
            NSInteger prevCount = [(NSString *)prevParts[2] integerValue];
            NSString *newEntry = [NSString stringWithFormat:@"%@$%@$%li",prevParts[0],prevParts[1],(long)prevCount+1];
            [view.activityLogs replaceObjectAtIndex:0 withObject:newEntry];
        }
    } else {
        [view.activityLogs insertObject:[NSString stringWithFormat:@"%@$%@$1",dayString,timeString] atIndex:0];
    }
    if (view.activityLogs.count > 10) {
        [view.activityLogs removeObjectAtIndex:10];
    }
    [[NSUserDefaults standardUserDefaults] setObject:view.activityLogs forKey:@"activityLog"];
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
    self.score = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
    self.activityLogs = [[NSUserDefaults standardUserDefaults] objectForKey:@"activityLog"];
    
    hitSoundUrl = [[NSBundle mainBundle] URLForResource: @"CashSound" withExtension:@"mp3"];
    miloAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    appDelegate.d.delegate = self;
    
    UIImage *backButtonImage = [UIImage imageNamed:@"miloBack.png"];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:backButtonImage forState:UIControlStateNormal];//this line for set only image on button
    backbutton.frame = CGRectMake(0, 0, backButtonImage.size.width/2.2, backButtonImage.size.height/2.2);
    [backbutton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    [backbutton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = back;
    
    UIImage *miloImage;
    if (appDelegate.d.t.activePeripheral.state == CBPeripheralStateConnected) {
        miloImage = [UIImage imageNamed:@"paired.png"];
    } else {
        miloImage = [UIImage imageNamed:@"notPaired.png"];
    }
    UIButton *miloButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [miloButton setImage:miloImage forState:UIControlStateNormal];
    miloButton.frame = CGRectMake(0, 0, miloImage.size.width/2.2, miloImage.size.height/2.2);
    [miloButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [miloButton setShowsTouchWhenHighlighted:NO];
    UIBarButtonItem *milo = [[UIBarButtonItem alloc] initWithCustomView:miloButton];
    self.navigationItem.rightBarButtonItem = milo;
    
    [self updateScore];
}

-(void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)applicationDidEnterBackground:(UIApplication *)application{
    [[NSUserDefaults standardUserDefaults] synchronize];
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

-(void) miloTriggered{
    self.score++;
    [counterViewController updateScoreForCounter:self];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:hitSoundUrl error:NULL];
    [self.player play];
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:4];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(self.miloImage.center.x - 5,self.miloImage.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(self.miloImage.center.x + 5, self.miloImage.center.y)]];
    [self.miloImage.layer addAnimation:shake forKey:@"position"];
}

- (IBAction)tempTrigger {
    [self miloTriggered];
}

- (IBAction)tempClear {
    self.score = 0;
}

-(void)updateScore{
    self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.score];
}


-(void) leftButtonPressed{
    [self miloTriggered];
}

-(void) rightButtonPressed{
    [self miloTriggered];
}

- (IBAction)moveMiloBird {
    Byte buzVal = 0x02;
    miloAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSData *d = [[NSData alloc] initWithBytes:&buzVal length:TI_KEYFOB_PROXIMITY_ALERT_WRITE_LEN];
    [appDelegate.d.t writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID p:appDelegate.d.t.activePeripheral data:d];
}

- (IBAction)moveMiloMouse {
    Byte buzVal = 0x01;
    miloAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSData *d = [[NSData alloc] initWithBytes:&buzVal length:TI_KEYFOB_PROXIMITY_ALERT_WRITE_LEN];
    [appDelegate.d.t writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID p:appDelegate.d.t.activePeripheral data:d];
}

- (IBAction)moveMiloRobot {
    Byte buzVal = 0x03;
    miloAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSData *d = [[NSData alloc] initWithBytes:&buzVal length:TI_KEYFOB_PROXIMITY_ALERT_WRITE_LEN];
    [appDelegate.d.t writeValue:TI_KEYFOB_PROXIMITY_ALERT_UUID characteristicUUID:TI_KEYFOB_PROXIMITY_ALERT_PROPERTY_UUID p:appDelegate.d.t.activePeripheral data:d];
}

-(void) viewWillAppear:(BOOL)animated{
    miloAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    UIImage *miloImage;
    if (appDelegate.d.t.activePeripheral.state == CBPeripheralStateConnected) {
        miloImage = [UIImage imageNamed:@"paired.png"];
    } else {
        miloImage = [UIImage imageNamed:@"notPaired.png"];
    }
    UIButton *miloButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [miloButton setImage:miloImage forState:UIControlStateNormal];
    miloButton.frame = CGRectMake(0, 0, miloImage.size.width/2.2, miloImage.size.height/2.2);
    [miloButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [miloButton setShowsTouchWhenHighlighted:NO];
    UIBarButtonItem *milo = [[UIBarButtonItem alloc] initWithCustomView:miloButton];
    self.navigationItem.rightBarButtonItem = milo;
}

@end
