//
//  challengeViewController.m
//  Milo
//
//  Created by Programming Account on 1/16/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "challengeViewController.h"
#import "CustomTimer.h"
#import "counterViewController.h"
#import "miloAppDelegate.h"

@interface challengeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet CustomTimer *timerView;
@property (weak, nonatomic) IBOutlet UILabel *multLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreAddLabels;
@property (weak, nonatomic) IBOutlet UIImageView *bonusTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *comboLabel;
@property (weak, nonatomic) IBOutlet UIImageView *miloImage;
@property (weak, nonatomic) IBOutlet UIView *gameOverView;
@property (weak, nonatomic) IBOutlet UILabel *gameOverScoreLabel;

@property (nonatomic) double timerAngle;
@property (nonatomic) NSInteger timeLeft;
@property (nonatomic, strong) NSTimer *angleTimer;
@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, strong) NSTimer *streakTimer;
@property (nonatomic) double angleInverval;
@property (nonatomic) NSInteger scoreBeforeStart;
@property (nonatomic) double timeInterval;

@property (nonatomic) NSInteger multiplier;

@property (strong, nonatomic) AVAudioPlayer *hitPlayer;
@property (strong, nonatomic) AVAudioPlayer *bonusPlayer;

@end

@implementation challengeViewController

NSURL *bonusSoundUrl;
NSURL *hitSoundUrl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gameOverView.hidden = YES;
    
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
    
    self.timeLeft = -1;
    self.score = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
    self.multiplier = 0;
    self.multLabel.hidden = YES;
    self.comboLabel.hidden = YES;
    self.bonusTimeLabel.hidden = NO;
    self.scoreAddLabels.hidden = YES;
    self.bonusTimeLabel.alpha = 0;
    self.activityLogs = [[NSUserDefaults standardUserDefaults] objectForKey:@"activityLog"];
    self.timerAngle = -M_PI/2;
    
    bonusSoundUrl = [[NSBundle mainBundle] URLForResource: @"BonusBell" withExtension:@"mp3"];
    hitSoundUrl = [[NSBundle mainBundle] URLForResource: @"CashSound" withExtension:@"mp3"];
    
    appDelegate.d.delegate = self;
    
    self.timeInterval = 0.05;
    self.angleInverval = M_PI*2/(15/self.timeInterval);
    
    UIImage *backButtonImage = [UIImage imageNamed:@"miloBack.png"];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:backButtonImage forState:UIControlStateNormal];//this line for set only image on button
    backbutton.frame = CGRectMake(0, 0, backButtonImage.size.width/2.2, backButtonImage.size.height/2.2);
    [backbutton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    [backbutton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = back;
    
    UIImage *titleImage = [UIImage imageNamed:@"PinballHeader.png"];
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, titleImage.size.width/2.2, titleImage.size.height/2.05)];
    UIView *titleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleImage.size.width/2.2, titleImage.size.height/2.05)];
    [titleContainer addSubview:titleView];
    titleView.image = titleImage;
    self.navigationItem.titleView = titleContainer;
    
    [self updateScore];
}

- (IBAction)closeSessionScore {
    [UIView animateWithDuration:0.3 animations:^{
        self.gameOverView.alpha = 0;
    } completion:^(BOOL finished){
        self.gameOverView.hidden = YES;
        self.gameOverView.alpha = 1;
    }];
}

-(NSMutableArray *)activityLogs{
    if (_activityLogs == nil) {
        _activityLogs = [NSMutableArray array];
    }
    return _activityLogs;
}

-(void)setMultiplier:(NSInteger)multiplier{
    _multiplier = multiplier;
    if (multiplier == 0) {
        self.multLabel.hidden = YES;
    } else {
        self.multLabel.hidden = NO;
        self.scoreAddLabels.text = [NSString stringWithFormat:@"+%li", (long)pow(2.0, self.multiplier-2)];
        self.multLabel.text = [NSString stringWithFormat:@"x%li", (long)self.multiplier];
    }
}

-(void)setTimerAngle:(double)timerAngle{
    _timerAngle = timerAngle;
}

-(void)updateScore{
    self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.score];
}

-(void)setScore:(NSInteger)score{
    _score = score;
    [[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:@"score"];
    [self updateScore];
}

-(void)setTimeLeft:(NSInteger)timeLeft{
    _timeLeft = timeLeft;
    [self updateTime];
    if (self.timeLeft == 0) {
        self.gameOverScoreLabel.text = [NSString stringWithFormat:@"%li", self.score - self.scoreBeforeStart];
        self.gameOverView.hidden = NO;
        self.timeLeftLabel.hidden = YES;
    }
}

-(void)blinkView:(UIView *)view withStartTime:(double)startTime waitTime:(double)waitTime andEndTime:(double)endTime{
    [UIView animateWithDuration:startTime animations:^(void){
        view.alpha = 1;
    }completion:^(BOOL finished){
        [UIView animateWithDuration:waitTime animations:^(void){
        } completion:^(BOOL finished){
            [UIView animateWithDuration:endTime animations:^(void){
                view.alpha = 0;
            }];
        }];
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) miloTriggered{
    self.hitPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:hitSoundUrl error:NULL];
    [self.hitPlayer play];
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:4];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(self.miloImage.center.x - 20,self.miloImage.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(self.miloImage.center.x + 20, self.miloImage.center.y)]];
    [self.miloImage.layer addAnimation:shake forKey:@"position"];
    
    if (self.timeLeft <= 0 && !self.streakTimer.isValid) {
        self.timeLeft = 15;
        self.scoreBeforeStart = self.score;
        if (self.gameOverView.hidden == NO) {
            [self closeSessionScore];
        }
        
        [self.angleTimer invalidate];
        self.timerAngle = -M_PI/2;
        self.angleTimer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(changeAngle:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.angleTimer forMode:NSDefaultRunLoopMode];
        
        [self.countTimer invalidate];
        self.countTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(onTimerFire:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSDefaultRunLoopMode];
    }
    self.multiplier++;
    [self.streakTimer invalidate];
    self.streakTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(cancelStreak:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.streakTimer forMode:NSDefaultRunLoopMode];
    if (self.multiplier == 8) {
        [self blinkView:self.bonusTimeLabel withStartTime:0.1 waitTime:2.0 andEndTime:0.6];
        
        self.bonusPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bonusSoundUrl error:NULL];
        [self.bonusPlayer play];
        
        self.timeLeft += 5;
        if (self.timeLeft > 15) {
            self.timeLeft = 15;
        }
        
        [self.angleTimer invalidate];
        self.timerAngle = -M_PI/2 + self.angleInverval * (15 - self.timeLeft) / self.timeInterval;
        self.angleTimer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(changeAngle:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.angleTimer forMode:NSDefaultRunLoopMode];
    }
    if (self.multiplier == 4) {
        self.comboLabel.hidden = NO;
        self.scoreAddLabels.hidden = NO;
    }
    [counterViewController updateScoreForChallenge:self];
}

- (IBAction)tempTrigger {
    [self miloTriggered];
}

- (IBAction)tempClear {
    self.score = 0;
}

-(void)onTimerFire:(NSTimer *)timer{
    if (self.timeLeft <= -1) {
        [timer invalidate];
    } else if (self.timeLeft < 0){
        [self.timerView setNeedsDisplay];
    }
    self.timeLeft--;
    
}

-(void)changeAngle:(NSTimer *)timer{
    self.timerAngle += self.angleInverval;
    if (self.timerAngle >= 3*M_PI/2){
        if (!self.streakTimer.isValid) {
            [self.timerView setDefaultAngle];
            self.timerAngle = -M_PI/2;
            self.multiplier = 0;
        } else {
            self.timerAngle = 3*M_PI/2;
        }
        [timer invalidate];
    }
    self.timerView.angle = self.timerAngle;
    [self.timerView setNeedsDisplay];
}

-(void)cancelStreak:(NSTimer *)timer{
    self.comboLabel.hidden = YES;
    if (self.multiplier < 4) {
        self.score++;
    } else {
        self.score += pow(2, self.multiplier-2);
    }
    self.multiplier = 0;
    self.multLabel.hidden = YES;
    self.scoreAddLabels.hidden = YES;
    [timer invalidate];
    [self updateTime];
    [self changeAngle:nil];
}

-(void)updateTime{
    if (self.timeLeft <= 0) {
        self.timeLeftLabel.text = @"0";
    } else {
        self.timeLeftLabel.text = [NSString stringWithFormat:@"%li", (long)self.timeLeft];
        [self blinkView:self.timeLeftLabel withStartTime:0.2 waitTime:0.4 andEndTime:0.4];
        self.timeLeftLabel.hidden = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)applicationDidEnterBackground:(UIApplication *)application{
    [[NSUserDefaults standardUserDefaults] synchronize];
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
