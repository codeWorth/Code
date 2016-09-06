//
//  ViewController.m
//  Matchmakeingisn
//
//  Created by Andrew Cummings on 7/18/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *findMatchButton;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (nonatomic, strong) NSString* username;
@property (nonatomic) NSInteger rank;
@property (nonatomic) NSInteger userID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.username = @"Login first.";
    self.rank = 0;
    [self update];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[ChatViewController class]]){
        ((ChatViewController*)segue.destinationViewController).userID = self.userID;
    }
}

-(void)update{
    self.usernameText.text = @"";
    self.passwordText.text = @"";
    
    self.usernameLabel.text = self.username;
    if (self.rank == 0){
        self.findMatchButton.enabled = NO;
        self.rankLabel.text = @"Login first.";
    } else {
        self.findMatchButton.enabled = YES;
        self.rankLabel.text = [NSString stringWithFormat:@"Rank: %ld", self.rank];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameText || textField ==  self.passwordText) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)login {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/login.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"name=%@&pass=%@", self.usernameText.text, self.passwordText.text];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            self.userID = [str intValue];

            [self getUserInformation];
            [self update];
            
            self.submitButton.enabled = NO;
        }];
        
        [uploadTask resume];
    }

}

-(void)getUserInformation{
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/playerdata.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSArray* items = [str componentsSeparatedByString:@","];

            self.username = [items objectAtIndex:0];
            self.rank = [(NSString*)[items objectAtIndex:1] integerValue];

            [self update];
        }];
        
        [uploadTask resume];
    }
}

- (IBAction)findMatch {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/addtoqueue.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSTimer* timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(scanMatches:) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }];
        
        [uploadTask resume];
    }
}

-(void)scanMatches:(NSTimer*)timer{
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/data.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if ([str length] > 0){
                [self performSegueWithIdentifier:@"matchFound" sender:self];
            } else {
                NSTimer* timer = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(scanMatches:) userInfo:nil repeats:NO];
                [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            }
        }];
        
        [uploadTask resume];
    }
}

@end
