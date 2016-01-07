//
//  PublicMacro.h
//  PRJ_GeneralFramework_ObjC
//
//  Created by 256app on 15/10/22.
//  Copyright © 2015年 C. All rights reserved.
//

#ifndef PublicMacro_h
#define PublicMacro_h

/******************************Lib***************************/
#import <BlocksKit/BlocksKit+UIKit.h>
#import <Masonry/Masonry.h>
/************************************************************/


/*************************ScreeenSize************************/
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/************************************************************/


/**************************iPhoneSize************************/
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define APP_DELEGATE ([UIApplication sharedApplication].delegate)

#define SYS_IOS_VEERSION ([ [ [ UIDevice currentDevice ] systemVersion ] floatValue ])
/************************************************************/

/*****************************宏定义**************************/
#define UIImageName(NSString) [UIImage imageNamed:(NSString)]

#define UIFontSize(CGFloat) [UIFont systemFontOfSize:CGFloat]

#define UIColorRGBA(rNSUInteger, gNSUInteger, bNSUInteger, aCGFloat) \
[UIColor colorWithRed:(rNSUInteger)/255.0 green:(gNSUInteger)/255.0 blue:(bNSUInteger)/255.0 alpha:(aCGFloat)]

#define UIColorBase UIColorRGBA(0, 171, 236, 1.0f)

#define UIColorWhite [UIColor whiteColor]

#define UIColorBlack [UIColor blackColor]

#define UIColorClear [UIColor clearColor]

#define UIColorRed [UIColor redColor]

#define RJPageCount @"10"

//#define kMainUrl @"http://112.124.48.189"
#define kMainUrl @"http://www.256app.com"

#define kApiUrl [NSString stringWithFormat:@"%@/meidu/index.php?g=App", kMainUrl]
/************************************************************/

#endif /* PublicMacro_h */
