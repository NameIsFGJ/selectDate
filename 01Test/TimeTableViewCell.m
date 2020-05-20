//
//  TimeTableViewCell.m
//  01Test
//
//  Created by 冯高杰 on 2020/5/20.
//  Copyright © 2020 冯高杰. All rights reserved.
//

#import "TimeTableViewCell.h"

@implementation TimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
  //  [self.timeButton setImage:[UIImage imageNamed:@"icon_normolImage"] forState:UIControlStateNormal];
   // [self.timeButton setImage:[UIImage imageNamed:@"icon_selectImage"] forState:UIControlStateSelected];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsSelect:(NSInteger)isSelect
{
    _isSelect = isSelect;
    if (isSelect)
    {
        [self.timeLabel setTextColor:[UIColor colorWithRed:250/255.0 green:105/255.0 blue:0 alpha:1]];
    }else
    {
        [self.timeLabel setTextColor:[UIColor blackColor]];
    }
}

@end
