//
//  BaseViewCtrl+Category.m
//  PRJ_GeneralFramework_ObjC
//
//  Created by C on 15/11/1.
//  Copyright © 2015年 C. All rights reserved.
//

#import "BaseViewCtrl+Category.h"

@implementation BaseViewCtrl (Category)

- (void)presentAlertViewControllerWithTitle:(NSString *)title message:(NSString *)message sureTitle:(NSString *)sureTitle
{
    if (SYS_IOS_VEERSION > 8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:sureTitle
                                                            style:UIAlertActionStyleDefault
                                                          handler:NULL]];
        [self presentViewController:alertController animated:YES completion:NULL];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:sureTitle
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}


//没调试好
- (void)presentActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherAction:(nullable UIAlertAction *)otherAction, ...
{
    if (SYS_IOS_VEERSION > 8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        va_list args;
        va_start(args, otherAction);
        if (otherAction) {
            UIAlertAction *action;
            while ((action = va_arg(args, UIAlertAction *))) {
                [alertController addAction:action];
            }
        }
        va_end(args);
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:NULL]];
        [self presentViewController:alertController animated:YES completion:NULL];
    }
}

@end
