//
//  ChatViewController.m
//  Matchmakeingisn
//
//  Created by Andrew Cummings on 7/19/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* awayUsername;
@property (nonatomic) NSInteger chatterID;

@property (strong, nonatomic) NSMutableString* chatHistory;

@property (weak, nonatomic) IBOutlet UITextView *chatBox;
@property (weak, nonatomic) IBOutlet UITextField *submitTextbox;

@property (nonatomic, strong) NSMutableURLRequest* chatDataRequest;
@property (nonatomic) NSInteger lastDataIndex;
@property (nonatomic) NSInteger lastSentIndex;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.username = @"not found";
    self.awayUsername = @"not found";
    
    [self setHomeUsername];
    
    [self setChatterInfo];
    
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/data.php"];
    
    self.chatDataRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [self.chatDataRequest setHTTPMethod:@"POST"];
    [self.chatDataRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.lastSentIndex = 0;
    
    self.chatHistory = [[NSMutableString alloc]init];
    
    NSTimer* timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(getChatInfo:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (IBAction)submitText {
    [self sendChatString:self.submitTextbox.text];
    self.submitTextbox.text = @"";
}

-(void)setHomeUsername{
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
            self.title = [NSString stringWithFormat:@"%@, chatting with %@", self.username, self.awayUsername];
        }];
        
        [uploadTask resume];
    }
}

-(void)setAwayUsername{
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/playerdata.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.chatterID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSArray* items = [str componentsSeparatedByString:@","];
            
            self.awayUsername = [items objectAtIndex:0];
            self.title = [NSString stringWithFormat:@"%@, chatting with %@", self.username, self.awayUsername];
        }];
        
        [uploadTask resume];
    }
}

-(void)setChatterInfo{
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/matchdata.php"];
    
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
            self.chatterID = [str integerValue];
            
            [self setAwayUsername];
        }];
        
        [uploadTask resume];
    }
}

-(void)getChatInfo:(NSTimer*)timer{
    if ([self.username isEqualToString:@"not found"] || [self.awayUsername isEqualToString:@"not found"]){
        return;
    }
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:self.chatDataRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSString* firstChar = [str substringToIndex:1];
            NSInteger firstNum = [firstChar integerValue];
            
            if (firstNum > self.lastDataIndex){
                self.lastDataIndex = firstNum;
                [self.chatHistory appendFormat:@"\n%@: %@", self.awayUsername, [str substringFromIndex:1]];
                self.chatBox.text = self.chatHistory;
            }
        }];
        
        [uploadTask resume];
    }
}

-(void)sendChatString:(NSString*)string{
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/uploadtomatch.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    self.lastSentIndex++;
    NSString* params = [NSString stringWithFormat:@"id=%ld&data=%ld%@", self.userID, self.lastSentIndex, string];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            [self.chatHistory appendFormat:@"\n%@: %@", self.username, string];
            self.chatBox.text = self.chatHistory;
        }];
        
        [uploadTask resume];
    }
}

@end
