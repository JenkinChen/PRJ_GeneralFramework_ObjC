//
//  NSString+Category.m
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/28.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>
#import "PublicMacro.h"

@implementation NSString (Category)

- (CGFloat)heightWithFont:(CGFloat)font width:(CGFloat)width
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        CGRect rectangle = [self boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(font)} context:nil];
        
        return rectangle.size.height;
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        CGSize size = [self sizeWithFont:UIFontSize(font) constrainedToSize:CGSizeMake(width, 10000)];
#pragma clang diagnostic pop
        return size.height;
    }
}

//手机号验证
- (BOOL)isValidMobile
{
    NSString *phoneRegex = @"^1([3-5]|7|8)\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

//邮箱
- (BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//邮编
- (BOOL)isValidatePost
{
    NSString *postRegex = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate *postTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", postRegex];
    return [postTest evaluateWithObject:self];
}

//注册合法字符
- (BOOL)isValidateUserName
{
    NSString *userNameRegex = @"^[\\u4E00-\\u9FA5\\uF900-\\uFA2D\\w]{2,10}$";
    //    NSString *userNameRegex = @"^[0-9a-zA-Z]{2,10}$";
    NSPredicate *userNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    return ![userNameTest evaluateWithObject:self];
}

- (BOOL)isValidatePWD
{
    NSString *pwdRegex = @"^(?!(?:\\d+|[a-zA-Z]+)$)[\\da-zA-Z]{4,16}$";
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdRegex];
    return [pwdTest evaluateWithObject:self];
}

- (NSString *)Md5_32Bit_String
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

- (NSInteger)charCount
{
    NSInteger charCount = 0;
    for (NSInteger i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        //判断中文
        if( ch > 0x4e00 && ch < 0x9fff) {
            charCount += 2;
        } else {
            charCount ++;
        }
    }
    return charCount;
}



@end
