//
//  ViewController.m
//  Clicker
//
//  Created by Programming Account on 2/4/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *enterTextField;
@property (weak, nonatomic) IBOutlet UILabel *shownText;
@property (weak, nonatomic) IBOutlet UIStepper *myStepper;

@property (strong, nonatomic) NSMutableArray *texts;
@property (nonatomic) NSInteger index;

@end

@implementation ViewController

@synthesize texts = _texts;

-(NSMutableArray *)texts{
    if (!_texts){
        _texts = [[NSMutableArray alloc]init];
    }
    return _texts;
}

- (IBAction)stepperChanged:(UIStepper *)sender {
    if (sender.value < [self.texts count] && sender.value >= 0){
        self.index = sender.value;
        self.shownText.text = [NSString stringWithFormat:@"%@",[self.texts objectAtIndex:sender.value]];
    } else {
        sender.value = self.index;
    }
}

- (IBAction)addTextClicked {
    [self.texts addObject:self.enterTextField.text];
    self.enterTextField.text = @"";
    if (self.myStepper.maximumValue == 0) {
        self.shownText.text = self.texts[0];
    }
    self.myStepper.maximumValue = [self.texts count]-1;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //load ur stuuuff
    
    self.enterTextField.delegate = self;
    self.myStepper.value = 0;
    self.myStepper.maximumValue = 0;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
