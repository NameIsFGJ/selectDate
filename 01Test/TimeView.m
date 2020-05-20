//
//  TimeView.m
//  01Test
//
//  Created by 冯高杰 on 2020/5/20.
//  Copyright © 2020 冯高杰. All rights reserved.
//

#import "TimeView.h"
#import <Masonry.h>
#import "TimeTableViewCell.h"

@interface TimeView ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSArray *buttonArray;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) NSArray *timeArray;
@property (strong, nonatomic) UITableView *mainView;
@property (assign, nonatomic) NSInteger selectCellID;
@property (strong, nonatomic) NSArray *statusArray;
@property (assign, nonatomic) NSInteger currentDay;
@property (assign, nonatomic) NSInteger currentStartHour;
@property (assign, nonatomic) NSInteger currentEndHour;
@property (strong, nonatomic) NSString *startHourMin;
@property (strong, nonatomic) NSString *endHourMin;
@end

#define KGrayColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]

@implementation TimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self makeUI];
    }
    return self;
}

 - (void)makeUI
 {
     self.currentDay = 0;
     self.currentStartHour = -1;
     self.currentEndHour = -1;
     
        UIView *contentView = [[UIView alloc]init];
        [self addSubview:contentView];
        contentView.backgroundColor = [UIColor whiteColor];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(300);
        }];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [contentView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.top.mas_equalTo(5);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [cancelButton setTitle:@"立即寄件" forState:UIControlStateNormal];
       [cancelButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(doorSend) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        [contentView addSubview:nameLabel];
        nameLabel.textColor = [UIColor blackColor];
     nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.text = @"期望上门时间";
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           // make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
           // make.top.equalTo(cancelButton.mas_top);
            make.size.mas_equalTo(CGSizeMake(160, 40));
            make.centerX.equalTo(contentView.mas_centerX).offset(30);
            
        }];
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
          [contentView addSubview:submitButton];
          [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
              make.right.mas_equalTo(-18);
              make.top.equalTo(cancelButton.mas_top);
              make.size.mas_equalTo(CGSizeMake(80, 30));
          }];
       [submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
          [submitButton setTitle:@"确定" forState:UIControlStateNormal];
          [submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
     UIView *lineView = [[UIView alloc]init];
     [contentView addSubview:lineView];
     [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.mas_equalTo(0);
         make.top.equalTo(cancelButton.mas_bottom).offset(10);
         make.height.mas_equalTo(.5);
     }];
     lineView.backgroundColor = [UIColor lightGrayColor];
     
     UIView *leftView = [[UIView alloc]init];
     [contentView addSubview:leftView];
     [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.bottom.mas_equalTo(0);
         make.top.equalTo(lineView.mas_bottom).offset(0);
         make.width.mas_equalTo(130);
     }];
     leftView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
     
     UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
     [leftView addSubview:button1];
     [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.top.right.mas_equalTo(0);
         make.height.mas_equalTo(50);
     }];
     button1.tag = 101;
     [button1 setTitle:@"今天" forState:UIControlStateNormal];
     [button1 setBackgroundColor:[UIColor whiteColor]];
     [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [button1 addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
     UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
         [leftView addSubview:button2];
         [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.right.mas_equalTo(0);
             make.height.mas_equalTo(50);
             make.top.equalTo(button1.mas_bottom).offset(0);
         }];
     button2.tag = 102;
         [button2 setTitle:@"明天" forState:UIControlStateNormal];
         [button2 setBackgroundColor:KGrayColor];
           [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [button2 addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
         UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
            [leftView addSubview:button3];
            [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(50);
                make.top.equalTo(button2.mas_bottom).offset(0);
            }];
            [button3 setTitle:@"后天" forState:UIControlStateNormal];
            [button3 setBackgroundColor:KGrayColor];
            [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button3.tag = 103;
      [button3 addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
     self.buttonArray = [NSArray arrayWithObjects:button1,button2,button3, nil];
     
     self.mainView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
     [contentView addSubview:self.mainView];
     [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.bottom.mas_equalTo(0);
         make.top.equalTo(leftView.mas_top).offset(0);
         make.left.equalTo(leftView.mas_right).offset(0);
     }];
     self.mainView.delegate = self;
     self.mainView.dataSource = self;
     [self.mainView registerNib:[UINib nibWithNibName:@"TimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"TimeTableViewCellID"];
     
     self.timeArray = [NSArray arrayWithObjects:@"08:00 - 09:00",@"09:00 - 10:00",@"10:00 - 11:00",@"11:00 - 12:00",@"14:00 - 15:00",@"15:00 - 16:00",@"16:00 - 17:00", nil];
     
     self.statusArray = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
     
     self.selectCellID = 0;
     UIView*bgView = [[UIView alloc]init];
          [self addSubview:bgView];
          [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
              
              make.left.top.right.mas_equalTo(0);
              make.bottom.equalTo(contentView.mas_top);
          }];
          bgView.backgroundColor = KGrayColor;
          bgView.alpha = .6;
          UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popView)];
          [bgView addGestureRecognizer:tap];
          bgView.userInteractionEnabled = YES;
         
}

- (void)popView
{
    self.missBlock();
}

- (void)selectButtonAction:(UIButton *)sender
{
    for(int i=0;i<self.buttonArray.count;i++) //遍历数组 找出所有的button
    {
        UIButton *btn = self.buttonArray[i];
        [btn setBackgroundColor:KGrayColor];
         btn.selected = NO;
    }
    sender.selected =YES;
    [sender setBackgroundColor:[UIColor whiteColor]];//选中button的颜色
    
    //  返回顶点
    [self.mainView setContentOffset:CGPointZero animated:YES];
    
   //  返回状态
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.selectCellID inSection:0];
    [self.mainView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    // 赋值
    if (sender.tag == 101)
    {
        self.currentDay = 0;
    }
    else if (sender.tag == 102)
    {
        self.currentDay = 1;
    }
    else if (sender.tag == 103)
    {
        self.currentDay = 2;
    }
}

// 上门取件
- (void)doorSend
{
    self.startHourMin = [self doorSendTime:0];
    self.endHourMin = [self doorSendTime:2];
    NSString * verifyStart = [self ConvertStrToTime:self.startHourMin];
    NSString *verifyEnd = [self ConvertStrToTime:self.endHourMin];
    NSDictionary *dic = @{
                          @"startHourMin":self.startHourMin,
                          @"endHourMin":self.endHourMin,
                          @"verifyStart":verifyStart,
                          @"verifyEnd":verifyEnd
                          
                         };
           self.passBlock(dic);
    [self popView];
}

// 确认按钮
- (void)submitButtonAction
{
    if (self.currentStartHour > -1 && self.currentEndHour > -1) {
        
        self.startHourMin = [self countDay:self.currentDay withHours:self.currentStartHour];
        self.endHourMin = [self countDay:self.currentDay withHours:self.currentEndHour];
        NSString * verifyStart = [self ConvertStrToTime:self.startHourMin];
        NSString *verifyEnd = [self ConvertStrToTime:self.endHourMin];
        NSDictionary *dic = @{
                              @"startHourMin":self.startHourMin,
                              @"endHourMin":self.endHourMin,
                              @"verifyStart":verifyStart,
                              @"verifyEnd":verifyEnd
                              
                            };
        self.passBlock(dic);
         [self popView];
    }else
    {
        NSLog(@"请选择时间");
    }
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.timeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellID = @"TimeTableViewCellID";
    TimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.timeLabel.text = self.timeArray[indexPath.row];
    cell.isSelect = [self.statusArray[indexPath.row] integerValue];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelect = YES;
    self.selectCellID = indexPath.row;
    
    // 赋值
    NSInteger currentCellID = indexPath.row;
    switch (currentCellID) {
        case 0:
        {
            self.currentStartHour = 8;
            self.currentEndHour = 9;
        }
            break;
        case 1:
              {
                  self.currentStartHour = 9;
                  self.currentEndHour = 10;
              }
            break;
        case 2:
              {
                  self.currentStartHour = 10;
                  self.currentEndHour = 11;
              }
            break;
        case 3:
                    {
                        self.currentStartHour = 11;
                         self.currentEndHour = 12;
                    }
                  break;
        case 4:
              {
                  self.currentStartHour = 14;
                  self.currentEndHour = 15;
              }
            break;
        case 5:
              {
                  self.currentStartHour = 15;
                  self.currentEndHour = 16;
              }
            break;
        case 6:
              {
                  self.currentStartHour = 16;
                  self.currentEndHour = 17;
              }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelect = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

// 获取某个时间的秒时间戳
- (NSString *)countDay:(NSInteger)day withHours:(NSInteger)hour
{
       NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        [greCalendar setTimeZone: timeZone];

        NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:[NSDate date]];
    
        //  定义一个NSDateComponents对象，设置一个时间点
        NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
        [dateComponentsForDate setDay:dateComponents.day+day];
        [dateComponentsForDate setMonth:dateComponents.month];
        [dateComponentsForDate setYear:dateComponents.year];
        [dateComponentsForDate setHour:hour];
        [dateComponentsForDate setMinute:00];

        NSDate *dateFromDateComponentsForDate = [greCalendar dateFromComponents:dateComponentsForDate];
        
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateFromDateComponentsForDate timeIntervalSince1970]];
    
    return timeSp;
}

// 当前上门
- (NSString *)doorSendTime:(NSInteger)hour
{
       NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        [greCalendar setTimeZone: timeZone];

        NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:[NSDate date]];

        //  定义一个NSDateComponents对象，设置一个时间点
        NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
        [dateComponentsForDate setDay:dateComponents.day];
        [dateComponentsForDate setMonth:dateComponents.month];
        [dateComponentsForDate setYear:dateComponents.year];
        [dateComponentsForDate setHour:dateComponents.hour+hour];
        [dateComponentsForDate setMinute:00];
        
        NSDate *dateFromDateComponentsForDate = [greCalendar dateFromComponents:dateComponentsForDate];
        
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateFromDateComponentsForDate timeIntervalSince1970]];
    
    return timeSp;
}



//   验证   时间戳 转 日期

- (NSString *)ConvertStrToTime:(NSString *)timeStr{

    long long time=[timeStr longLongValue];

    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString*timeString=[formatter stringFromDate:date];

    return timeString;

}
@end
