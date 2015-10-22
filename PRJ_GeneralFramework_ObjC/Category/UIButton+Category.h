//
//  UIButton+Category.h
//  eTalk
//
//  Created by 256app on 15/9/7.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

/** 计时器 */
- (dispatch_source_t)gcd_CountDown;

@end
