//
//  activityTableViewController.m
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "activityTableViewController.h"
#import "ActivityItem.h"
#import "activityTableViewCell.h"

@interface activityTableViewController ()

@property (nonatomic, strong) NSArray *entries;

@end

@implementation activityTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *activityConverter = [NSMutableArray array];
    
    NSArray *activityLog = [[NSUserDefaults standardUserDefaults]arrayForKey:@"activityLog"];
    for (NSString *item in activityLog) {
        NSArray *parts = [item componentsSeparatedByString:@"$"];
        NSString *firstPart = parts[0];
        NSString *secondPart = parts[1];
        NSInteger thirdPart = [(NSString *)parts[2] integerValue];
        ActivityItem *newItem = [ActivityItem itemWithDate:firstPart andTime:secondPart];
        newItem.times = thirdPart;
        [activityConverter addObject:newItem];
    }
    self.entries = activityConverter;
    [self tableView].delegate = self;
    [self tableView].dataSource = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"LogItem";
    
    activityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    ActivityItem *thisItem = self.entries[indexPath.row];
    cell.dateLabel.text = thisItem.date;
    cell.timeLabel.text = thisItem.time;
    cell.timesLabel.text = [NSString stringWithFormat:@"%li", (long)thisItem.times];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
