//
//  UIButton+Category.m
//  eTalk
//
//  Created by 256app on 15/9/7.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        self.alpha = 1.0;
    }
    else {
        self.alpha = 0.5;
    }
}

- (dispatch_source_t)gcd_CountDown
{
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        if(timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                               [self setEnabled:YES];
                           });
        } else {
            int seconds = timeout % 61;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                NSString *title = [NSString stringWithFormat:@"%@s重新获取",strTime];
                [self setTitle:title forState:UIControlStateNormal];
                [self setEnabled:NO];
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
    
    return timer;
}

@end
