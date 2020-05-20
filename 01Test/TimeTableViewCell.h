//
//  TimeTableViewCell.h
//  01Test
//
//  Created by 冯高杰 on 2020/5/20.
//  Copyright © 2020 冯高杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (assign, nonatomic) NSInteger isSelect;
@end

NS_ASSUME_NONNULL_END
