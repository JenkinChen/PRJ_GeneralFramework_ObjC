//
//  HttpRequest.h
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/7.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestDelegate.h"
#import "BaseViewCtrl.h"

@interface HttpRequest : NSObject

- (instancetype)initUrl:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode delegate:(BaseViewCtrl<HttpRequestDelegate> *)viewController object:(id)object;

- (void)POST;

/**
*  POST请求数据
*
*  @param URLString      请求地址
*  @param parameters     请求POST参数
*  @param requestCode    请求标识符代码
*  @param viewController 请求对象
*  @param object         请求传递参数
*/
+ (void)POST:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode delegate:(BaseViewCtrl<HttpRequestDelegate> *)viewController object:(id)object;

+ (void)POST:(NSString *)URLString parameters:(id)parameters requestCode:(NSInteger)requestCode delegate:(BaseViewCtrl<HttpRequestDelegate> *)viewController;

@end
