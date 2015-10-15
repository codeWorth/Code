//
//  leaderboardTableViewCell.h
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol leaderboardTableViewCellDelegate <NSObject>

-(void)showInfoPageForCell:(UITableViewCell *)cell;

@end

@interface leaderboardTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *catImage;
@property (nonatomic, weak) IBOutlet UILabel *catName;
@property (nonatomic, weak) IBOutlet UILabel *catScore;
@property (nonatomic, weak) IBOutlet UIButton *infoButton;

@property (nonatomic, strong) id<leaderboardTableViewCellDelegate> delegate;

@end
