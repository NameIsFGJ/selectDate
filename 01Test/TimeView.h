//
//  TimeView.h
//  01Test
//
//  Created by 冯高杰 on 2020/5/20.
//  Copyright © 2020 冯高杰. All rights reserved.
//

#import <UIKit/UIKit.h>

// 页面消失
typedef void(^dismissViewBlock)(void);

// 传值
typedef void(^passValueBlock)(NSDictionary * _Nullable dic);

NS_ASSUME_NONNULL_BEGIN

@interface TimeView : UIView
@property (copy, nonatomic) dismissViewBlock missBlock;
@property (copy, nonatomic) passValueBlock passBlock;

@end

NS_ASSUME_NONNULL_END
