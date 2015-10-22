//
//  HttpRequestDelegate.h
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/10.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpRequestDelegate <NSObject>

- (void)httpRequestSuccess:(NSInteger)requestCode result:(id)responseObject object:(id)object;

- (void)httpRequestSuccess:(NSInteger)requestCode result:(id)responseObject;

- (void)httpRequestFailure:(NSInteger)requestCode error:(NSError *)error;

@end