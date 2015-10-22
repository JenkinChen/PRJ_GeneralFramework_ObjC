//
//  NSString+Category.h
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/28.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)

/**
 * 计算高度
 *
 *  @param font  字体大小
 *  @param width 宽度
 *
 *  @return 高度
 */
- (CGFloat)heightWithFont:(CGFloat)font width:(CGFloat)width;

/**
 *  手机号验证
 *
 *  @param mobile 手机号
 *
 *  @return YES是，NO不是
 */
- (BOOL)isValidMobile;

/**
 *  判断邮箱是否有效
 *
 *  @param email 字符串邮箱
 *
 *  @return YES有效，NO无效
 */
- (BOOL)isValidateEmail;

/**
 *  判断邮编是否有效
 *
 *  @param post 邮编
 *
 *  @return YES有效，NO无效
 */
- (BOOL)isValidatePost;

/**
 *  用以判断注册是否合法字符
 *
 *  @param userName 注册用户名
 *
 *  @return YES有效,NO无效
 */
- (BOOL)isValidateUserName;

- (BOOL)isValidatePWD;

/**
 *  32位MD5加密方式
 *
 *  @param srcString 需要加密的字符串
 *
 *  @return 加密后字符串
 */
- (NSString *)Md5_32Bit_String;

/**
 *  计算字符个数
 *
 *  @return 字符个数
 */
- (NSInteger)charCount;

@end
