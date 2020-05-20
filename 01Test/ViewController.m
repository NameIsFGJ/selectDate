//
//  ViewController.m
//  01Test
//
//  Created by 冯高杰 on 2020/5/20.
//  Copyright © 2020 冯高杰. All rights reserved.
//

#import "ViewController.h"
#import "TimeView.h"

@interface ViewController ()
@property (strong ,nonatomic) TimeView *timeView;
@end
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.timeView = [[TimeView alloc]init];
    [self.view addSubview:self.timeView];
    self.timeView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    __weak ViewController *wakeSelf = self;
    
    self.timeView.missBlock = ^{
         wakeSelf.timeView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    };
    self.timeView.passBlock = ^(NSDictionary * _Nullable dic) {
        NSLog(@"result = %@",dic);
    };
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    [UIView animateWithDuration:.3 animations:^{
         self.timeView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
    
}

@end
