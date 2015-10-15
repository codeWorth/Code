//
//  editProfileViewController.m
//  MultiuserTest
//
//  Created by Programming Account on 5/31/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "editProfileViewController.h"
#import "multiuserTestViewController.h"

@interface editProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;

-(void)takePhoto;

@end

@implementation editProfileViewController

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
    self.imagePickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else
    {
        [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    self.imagePickerController.delegate = self;
    
    self.title = [NSString stringWithFormat:@"Edit %@",self.name];
    self.descriptionText.text = self.description;
    self.imageView.image = self.image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.descriptionText.textAlignment = NSTextAlignmentCenter;
    self.nameTextField.text = self.name;
    self.nameTextField.delegate = self;
    self.descriptionText.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePicture {
    [self takePhoto];
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

- (IBAction)doneButton:(UIBarButtonItem *)sender {
    self.sender.name = self.name;
    self.sender.description = self.description;
    self.sender.image = self.image;
    [self.sender updateUI];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    self.name = self.nameTextField.text;
    self.title = [NSString stringWithFormat:@"Edit %@",self.name];
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        self.description = textView.text;
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)updateUI{
    self.title = [NSString stringWithFormat:@"Edit %@",self.name];
    self.descriptionText.text = self.description;
    self.imageView.image = self.image;
    self.nameTextField.text = self.name;
}

- (void)takePhoto{
    // Place image picker on the screen
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.imageView.image = image;
    self.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
